import 'package:flutter/material.dart';
import 'package:futly_scout/routes/app_routes.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/widgets/common/app_scaffold.dart';
import 'package:futly_scout/widgets/reports/heatmap_widget.dart';
import 'package:futly_scout/widgets/reports/stats_summary_widget.dart';
import 'package:futly_scout/widgets/reports/export_buttons.dart';

/// Post-game report screen
class PostGameReportScreen extends StatefulWidget {
  final String matchId;

  const PostGameReportScreen({
    Key? key,
    required this.matchId,
  }) : super(key: key);

  @override
  State<PostGameReportScreen> createState() => _PostGameReportScreenState();
}

class _PostGameReportScreenState extends State<PostGameReportScreen>
    with SingleTickerProviderStateMixin {
  late String _matchId;
  late TabController _tabController;
  late Future<void> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _matchId = widget.matchId;
    _tabController = TabController(length: 3, vsync: this);
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    // Load match and events
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Relatório da Partida',
      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Resumo'),
                  Tab(text: 'Análise'),
                  Tab(text: 'Comparação'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Resumo tab
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            HeatmapWidget(
                              events: [
                                {'pitchX': 0.3, 'pitchY': 0.4, 'weight': 5},
                                {'pitchX': 0.5, 'pitchY': 0.5, 'weight': 8},
                                {'pitchX': 0.7, 'pitchY': 0.3, 'weight': 6},
                              ],
                            ),
                            const SizedBox(height: 16),
                            StatsSummaryWidget(
                              totalEvents: 25,
                              positiveEvents: 18,
                              negativeEvents: 7,
                              rating: 7.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Análise tab
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Gerar Análise com IA',
                              style:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Análise com IA: Jogador teve ótima performance técnica...',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.auto_awesome),
                              label: const Text('Gerar Análise'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'Exportar Relatório',
                              style:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            ExportButtons(
                              onExportPDF: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('PDF exportado com sucesso'),
                                  ),
                                );
                              },
                              onExportCSV: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('CSV exportado com sucesso'),
                                  ),
                                );
                              },
                              onExportPresentation: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Apresentação exportada com sucesso',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Comparação tab
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Comparar com outro jogador',
                              style:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                AppRoutes.comparison,
                              ),
                              icon: const Icon(Icons.compare),
                              label: const Text('Abrir Comparação'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
