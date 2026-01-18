import 'package:flutter/material.dart';
import 'package:futly_scout/environment/app_environment.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/widgets/common/app_scaffold.dart';
import 'package:futly_scout/widgets/reports/radar_chart_widget.dart';
import 'package:futly_scout/widgets/players/verdict_slider.dart';

class ComparisonScreen extends StatefulWidget {
  final String? playerAId;
  final String? playerBId;

  const ComparisonScreen({
    Key? key,
    this.playerAId,
    this.playerBId,
  }) : super(key: key);

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  String? _selectedPlayerAId;
  String? _selectedPlayerBId;

  // Mock de dados para o gráfico
  final Map<String, double> _statsA = {
    'Técnica': 7.5,
    'Tática': 6.0,
    'Física': 8.2,
    'Mental': 7.0
  };
  final Map<String, double> _statsB = {
    'Técnica': 8.0,
    'Tática': 7.5,
    'Física': 6.5,
    'Mental': 6.8
  };

  @override
  void initState() {
    super.initState();
    _selectedPlayerAId = widget.playerAId;
    _selectedPlayerBId = widget.playerBId;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Comparação',
      showAppBar: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- HEADER DE SELEÇÃO ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          'Comparativo',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder(
                      future: AppEnvironment.playerRepository.getPlayers(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const LinearProgressIndicator();
                        }

                        final players = snapshot.data ?? [];

                        return Row(
                          children: [
                            // JOGADOR A
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Jogador A',
                                      style: TextStyle(
                                          color: AppTheme.primaryBlue,
                                          fontSize: 12)),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    value: _selectedPlayerAId,
                                    hint: const Text('Selecionar'),
                                    underline: Container(
                                        height: 2, color: AppTheme.primaryBlue),
                                    items: players
                                        .map((p) => DropdownMenuItem(
                                            value: p.id,
                                            child: Text(p.name,
                                                overflow:
                                                    TextOverflow.ellipsis)))
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _selectedPlayerAId = v),
                                  ),
                                ],
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('VS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),

                            // JOGADOR B
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('Jogador B',
                                      style: TextStyle(
                                          color: AppTheme.errorRed,
                                          fontSize: 12)),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    value: _selectedPlayerBId,
                                    hint: const Text('Selecionar'),
                                    underline: Container(
                                        height: 2, color: AppTheme.errorRed),
                                    alignment: AlignmentDirectional.centerEnd,
                                    items: players
                                        .map((p) => DropdownMenuItem(
                                            value: p.id,
                                            child: Text(p.name,
                                                overflow:
                                                    TextOverflow.ellipsis)))
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _selectedPlayerBId = v),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              // --- CONTEÚDO DA COMPARAÇÃO ---
              if (_selectedPlayerAId != null && _selectedPlayerBId != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text('Raio-X Técnico',
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 16),

                      // ✅ CORREÇÃO AQUI: Removido o SizedBox(height: 300)
                      // Agora o widget cresce conforme o conteúdo precisa
                      RadarChartWidget(
                        playerScores: _statsA,
                        baselineScores: _statsB,
                        playerName: 'Comparação',
                      ),

                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Veredito (Sliders)
                      Text('Veredito do Scout',
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 24),

                      VerdictSlider(
                        label: 'Quem decide melhor sob pressão?',
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 24),
                      VerdictSlider(
                        label: 'Quem tem maior potencial de revenda?',
                        onChanged: (val) {},
                      ),

                      const SizedBox(height: 40),

                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Relatório de Comparação Salvo!')),
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Salvar Relatório'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                )
              else
                // Estado Vazio
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.compare_arrows,
                            size: 64, color: Colors.white.withOpacity(0.2)),
                        const SizedBox(height: 16),
                        const Text(
                            'Selecione os dois jogadores acima\npara iniciar o duelo.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
