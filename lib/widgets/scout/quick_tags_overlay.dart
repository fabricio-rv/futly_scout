import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Overlay showing quick tags after event recording
class QuickTagsOverlay extends StatelessWidget {
  final List<String> tags;
  final Duration displayDuration;

  const QuickTagsOverlay({
    Key? key,
    required this.tags,
    this.displayDuration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGreen, width: 1),
      ),
      child: Wrap(
        spacing: 8,
        children: [
          for (final tag in tags)
            Chip(
              label: Text(tag),
              backgroundColor: AppTheme.primaryGreen,
              labelStyle: const TextStyle(
                color: AppTheme.backgroundDark,
                fontWeight: FontWeight.bold,
              ),
              onDeleted: null,
            ),
        ],
      ),
    );
  }
}
