import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Stats summary widget for post-game report
class StatsSummaryWidget extends StatelessWidget {
  final int totalEvents;
  final int positiveEvents;
  final int negativeEvents;
  final double rating;

  const StatsSummaryWidget({
    Key? key,
    required this.totalEvents,
    required this.positiveEvents,
    required this.negativeEvents,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negativePercent =
        totalEvents > 0 ? (negativeEvents / totalEvents * 100) : 0;
    final positivePercent =
        totalEvents > 0 ? (positiveEvents / totalEvents * 100) : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Overall rating card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.primaryGreen, width: 2),
            ),
            child: Column(
              children: [
                const Text(
                  'Avaliação Geral',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${rating.toStringAsFixed(1)}/10',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Stats grid
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _StatCard('Total', '$totalEvents', AppTheme.primaryBlue),
              _StatCard(
                'Positivos',
                '$positiveEvents',
                AppTheme.successGreen,
              ),
              _StatCard(
                'Negativos',
                '$negativeEvents',
                AppTheme.errorRed,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Efficiency bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: positivePercent / 100,
                    backgroundColor: AppTheme.backgroundDark,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppTheme.successGreen,
                    ),
                    minHeight: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${positivePercent.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
