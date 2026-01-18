import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Evolution timeline widget showing player role changes over time
class EvolutionTimelineWidget extends StatelessWidget {
  final List<Map<String, dynamic>> evolutionHistory; // [{date, role}, ...]

  const EvolutionTimelineWidget({
    Key? key,
    required this.evolutionHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (evolutionHistory.isEmpty) {
      return const Center(
        child: Text(
          'Sem histórico de evolução',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < evolutionHistory.length; i++)
          _EvolutionItem(
            entry: evolutionHistory[i],
            isFirst: i == 0,
            isLast: i == evolutionHistory.length - 1,
          ),
      ],
    );
  }
}

class _EvolutionItem extends StatelessWidget {
  final Map<String, dynamic> entry;
  final bool isFirst;
  final bool isLast;

  const _EvolutionItem({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Timeline dot
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.backgroundDark,
                width: 3,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Timeline line (above and below)
          Column(
            children: [
              if (!isFirst)
                Container(
                  width: 2,
                  height: 16,
                  color: AppTheme.primaryGreen,
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Event content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['date'] ?? 'Data desconhecida',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry['role'] ?? 'Papel desconhecido',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
