import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/widgets/common/app_scaffold.dart';
import 'package:futly_scout/widgets/common/status_chip.dart';
import 'package:futly_scout/widgets/common/primary_fab.dart';
import 'package:futly_scout/routes/app_routes.dart';
import 'package:futly_scout/services/sync_service.dart';
import 'package:futly_scout/environment/app_environment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _loadDataFuture;
  final _syncService = SyncService();
  String _searchText = ''; // Variável para controlar a busca

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Home',
      showAppBar: false,
      body: SafeArea(
        child: FutureBuilder(
          future: _loadDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER (Olá + Sincronizado + Sininho) ---
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Olá, João',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Flamengo Academy 🏆',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Status e Notificação
                        Row(
                          children: [
                            StreamBuilder<SyncState>(
                              stream: _syncService.syncStateStream,
                              initialData: SyncState.synced,
                              builder: (context, snapshot) {
                                return StatusChip(
                                  syncState: snapshot.data ?? SyncState.synced,
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            // Botão de Sininho (Alertas)
                            IconButton(
                              onPressed: () {
                                // Aqui você pode navegar para uma tela de alertas futura
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Navegar para Notificações')),
                                );
                              },
                              icon: const Icon(Icons.notifications_outlined),
                              color: AppTheme.textPrimary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- BARRA DE PESQUISA ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar jogo, time ou atleta...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: AppTheme.surfaceDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- TÍTULO DA LISTA ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Relatórios Recentes',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        // Opcional: Filtro extra
                        Icon(Icons.filter_list,
                            color: AppTheme.textSecondary, size: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- LISTA DE PARTIDAS (VERTICAL) ---
                  FutureBuilder(
                    future: AppEnvironment.matchRepository.getRecentMatches(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Erro ao carregar partidas'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var matches = snapshot.data ?? [];

                      // Filtro local pela barra de pesquisa
                      if (_searchText.isNotEmpty) {
                        matches = matches.where((m) {
                          final searchLower = _searchText.toLowerCase();
                          final comp = (m.competition ?? '').toLowerCase();
                          final teamA = (m.teamA ?? '').toLowerCase();
                          final teamB = (m.teamB ?? '').toLowerCase();
                          // Supondo que match tenha playerName futuramente
                          // final player = (m.playerName ?? '').toLowerCase();
                          return comp.contains(searchLower) ||
                              teamA.contains(searchLower) ||
                              teamB.contains(searchLower);
                        }).toList();
                      }

                      if (matches.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: Text(
                              'Nenhum relatório encontrado.',
                              style: TextStyle(color: AppTheme.textSecondary),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: matches.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final match = matches[index];
                          return _MatchCardVertical(
                            match: match,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.postGameReport,
                                arguments: {'matchId': match.id},
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  // Espaço extra para o FAB não cobrir o último item
                  const SizedBox(height: 80),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: PrimaryFAB(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.matchSetup),
        tooltip: 'Nova Partida',
        icon: Icons.add,
      ),
    );
  }

  @override
  void dispose() {
    _syncService.dispose();
    super.dispose();
  }
}

/// Novo Card Vertical mais detalhado
class _MatchCardVertical extends StatelessWidget {
  final dynamic match;
  final VoidCallback onTap;

  const _MatchCardVertical({
    required this.match,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Tenta pegar o nome do jogador (Mock ou propriedade futura)
    // Se o objeto match não tiver 'playerName', usamos um placeholder
    final playerName = (match.toJson().containsKey('playerName'))
        ? match.playerName
        : 'Vitinho - Atacante';
    // Nota: Ajustei para 'Vitinho #10' apenas visualmente se não vier do banco

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linha 1: Competição e Data (opcional)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    match.competition ?? 'Amistoso',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: AppTheme.textSecondary, size: 16),
                ],
              ),
              const SizedBox(height: 12),

              // Linha 2: Placar Grande
              Row(
                children: [
                  Expanded(
                    child: Text(
                      match.teamA ?? 'Time A',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Text(
                      '${match.scoreA} x ${match.scoreB}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.successGreen,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      match.teamB ?? 'Time B',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Colors.white10),
              const SizedBox(height: 12),

              // Linha 3: Jogador Analisado
              Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: AppTheme.primaryBlue,
                    child: Icon(Icons.person, size: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Analisado: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  Text(
                    playerName, // Nome do jogador aqui
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
