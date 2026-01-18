import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Radar chart widget for comparing player against baseline
class RadarChartWidget extends StatelessWidget {
  final Map<String, double> playerScores;
  final Map<String, double> baselineScores;
  final String playerName;

  const RadarChartWidget({
    Key? key,
    required this.playerScores,
    required this.baselineScores,
    required this.playerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comparação com Baseline',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // Simplified radar representation using bars
          for (final entry in playerScores.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: entry.value / 100.0,
                            backgroundColor: AppTheme.backgroundDark,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryGreen,
                            ),
                            minHeight: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 40,
                        child: Text(
                          '${entry.value.toStringAsFixed(0)}%',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
