import 'package:flutter/material.dart';
import 'package:futly_scout/environment/app_environment.dart';
import 'package:futly_scout/routes/app_routes.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/widgets/common/app_scaffold.dart';
import 'package:futly_scout/widgets/players/mini_pitch_zones_widget.dart';
import 'package:futly_scout/widgets/players/evolution_timeline_widget.dart';
import 'package:futly_scout/widgets/players/trait_chip.dart';

class PlayerDetailScreen extends StatefulWidget {
  final String playerId;

  const PlayerDetailScreen({
    Key? key,
    required this.playerId,
  }) : super(key: key);

  @override
  State<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Perfil do Jogador',
      showAppBar:
          false, // Removemos para fazer um header customizado mais bonito

      // ✅ Botão Flutuante de Comparação
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes
                .comparison, // Certifique-se que essa rota existe no app.dart
            arguments: {
              'playerAId':
                  widget.playerId, // Já manda esse jogador pré-selecionado
            },
          );
        },
        backgroundColor: AppTheme.primaryBlue,
        icon: const Icon(Icons.compare_arrows),
        label: const Text('Comparar'),
      ),

      body: SafeArea(
        child: FutureBuilder(
          future:
              AppEnvironment.playerRepository.getPlayerById(widget.playerId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('Jogador não encontrado'));
            }

            final player = snapshot.data!;

            return Column(
              children: [
                // --- Header Customizado com Botão Voltar ---
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppTheme.surfaceDark,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Navegar para edição
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Hero(
                            tag:
                                'player_${player.id}', // Animação suave da foto
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(player.photoUrl),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  player.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryBlue
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        player.primaryPositionCode,
                                        style: const TextStyle(
                                            color: AppTheme.primaryBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '•  ${player.teamName}',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${player.age} anos  •  ${player.currentRole}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Tabs
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppTheme.primaryGreen,
                  tabs: const [
                    Tab(text: 'Bio'),
                    Tab(text: 'Análise'),
                    Tab(text: 'Evolução'),
                  ],
                ),

                // Tab Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Bio Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(context, 'Dados Físicos'),
                            _buildInfoRow(
                                'Altura', '${player.heightCm ?? "-"} cm'),
                            _buildInfoRow(
                                'Peso', '${player.weightKg ?? "-"} kg'),
                            _buildInfoRow('Pé Dominante', player.dominantFoot),

                            const SizedBox(height: 24),
                            _buildSectionTitle(
                                context, 'Mapa de Calor (Temporada)'),
                            const SizedBox(height: 12),
                            // Exemplo de uso do MiniPitch
                            MiniPitchZonesWidget(
                                zones: const ['Esquerda', 'Centro']),
                          ],
                        ),
                      ),

                      // Análise Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(context, 'Pontos Fortes'),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: player.positiveTraits
                                  .map((t) =>
                                      TraitChip(trait: t, isPositive: true))
                                  .toList(),
                            ),
                            const SizedBox(height: 24),
                            _buildSectionTitle(context, 'Pontos a Melhorar'),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: player.negativeTraits
                                  .map((t) =>
                                      TraitChip(trait: t, isPositive: false))
                                  .toList(),
                            ),
                            const SizedBox(height: 24),
                            _buildSectionTitle(context, 'Observações do Scout'),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceDark,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white10),
                              ),
                              child: Text(
                                player.notes ??
                                    "Nenhuma observação registrada.",
                                style: const TextStyle(
                                    color: Colors.white70, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Evolução Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(
                                context, 'Linha do Tempo Tática'),
                            EvolutionTimelineWidget(
                                evolutionHistory: player.evolutionHistory),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
