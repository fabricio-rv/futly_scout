import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Trait chip widget
class TraitChip extends StatelessWidget {
  final String trait;
  final bool isPositive;
  final VoidCallback? onRemove;

  const TraitChip({
    Key? key,
    required this.trait,
    required this.isPositive,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppTheme.successGreen : AppTheme.errorRed;

    return Chip(
      label: Text(
        trait,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
      onDeleted: onRemove,
      deleteIcon: const Icon(Icons.clear, size: 16),
      side: BorderSide.none,
    );
  }
}
