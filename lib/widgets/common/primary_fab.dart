import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Primary floating action button
class PrimaryFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final String tooltip;
  final IconData icon;
  final bool isLoading;

  const PrimaryFAB({
    Key? key,
    required this.onPressed,
    required this.tooltip,
    this.icon = Icons.add,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isLoading ? null : onPressed,
      backgroundColor: AppTheme.primaryGreen,
      tooltip: tooltip,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppTheme.backgroundDark),
                strokeWidth: 2,
              ),
            )
          : Icon(
              icon,
              color: AppTheme.backgroundDark,
              size: 28,
            ),
    );
  }
}
