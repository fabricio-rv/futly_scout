import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Undo FAB for removing last event
class UndoFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const UndoFAB({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppTheme.errorRed,
      tooltip: 'Desfazer último evento',
      child: const Icon(Icons.undo),
    );
  }
}
