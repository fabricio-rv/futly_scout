import 'package:flutter/material.dart';
import 'package:futly_scout/environment/app_environment.dart';
import 'package:futly_scout/models/match.dart';
import 'package:futly_scout/routes/app_routes.dart';
import 'package:futly_scout/constants/app_theme.dart';

import 'package:futly_scout/widgets/common/app_scaffold.dart';
import 'package:uuid/uuid.dart';

/// Match setup screen
class MatchSetupScreen extends StatefulWidget {
  const MatchSetupScreen({Key? key}) : super(key: key);

  @override
  State<MatchSetupScreen> createState() => _MatchSetupScreenState();
}

class _MatchSetupScreenState extends State<MatchSetupScreen> {
  final _competitionController = TextEditingController();
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedPlayerId = '';
  String _selectedTemplateId = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _competitionController.dispose();
    _teamAController.dispose();
    _teamBController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _startMatch() async {
    if (_competitionController.text.isEmpty ||
        _teamAController.text.isEmpty ||
        _teamBController.text.isEmpty ||
        _selectedPlayerId.isEmpty ||
        _selectedTemplateId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final matchId = const Uuid().v4();
      final match = Match(
        id: matchId,
        competition: _competitionController.text,
        teamA: _teamAController.text,
        teamB: _teamBController.text,
        dateIso: DateTime.now().toIso8601String(),
        location: _locationController.text,
        playerId: _selectedPlayerId,
        scoreA: 0,
        scoreB: 0,
        isFinished: false,
        minutesPlayed: 0,
        weightsTemplateId: _selectedTemplateId,
      );

      await AppEnvironment.matchRepository.createMatch(match);

      if (mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.liveScout,
          arguments: {'matchId': matchId},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Preparar Partida',
      showAppBar: false, // ✅ Remove o título do topo
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Informações da Partida',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _competitionController,
                  decoration: const InputDecoration(
                    hintText: 'Competição (ex: Campeonato Carioca)',
                    prefixIcon: Icon(Icons.sports_soccer),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _teamAController,
                        decoration: const InputDecoration(
                          hintText: 'Time A',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('vs',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _teamBController,
                        decoration: const InputDecoration(
                          hintText: 'Time B',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: 'Local',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 24),

                // Player selection
                Text(
                  'Jogador para Scouting',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                FutureBuilder(
                  future: AppEnvironment.playerRepository.getPlayers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final players = snapshot.data ?? [];
                      return DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedPlayerId.isEmpty
                            ? null
                            : _selectedPlayerId,
                        hint: const Text('Selecione um jogador'),
                        items: players
                            .map((p) => DropdownMenuItem(
                                  value: p.id,
                                  child: Text(p.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedPlayerId = value ?? '');
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(height: 24),

                // Template selection
                Text(
                  'Modelo de Avaliação',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                FutureBuilder(
                  future: AppEnvironment.configRepository.getTemplates(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final templates = snapshot.data ?? [];
                      return DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedTemplateId.isEmpty
                            ? null
                            : _selectedTemplateId,
                        hint: const Text('Selecione um modelo'),
                        items: templates
                            .map((t) => DropdownMenuItem(
                                  value: t.id,
                                  child: Text(t.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedTemplateId = value ?? '');
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _isLoading ? null : _startMatch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Iniciar Partida',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
