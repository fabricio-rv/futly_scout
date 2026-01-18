import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Action button for scout event recording with tap/swipe/long-press support
class ActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onLongPress;
  final Color color;
  final bool isSelected;

  const ActionButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onLongPress,
    this.color = AppTheme.primaryBlue,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onLongPress: widget.onLongPress,
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0 && widget.onSwipeDown != null) {
          widget.onSwipeDown!();
        } else if (details.primaryVelocity! < 0 && widget.onSwipeUp != null) {
          widget.onSwipeUp!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected ? widget.color : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.color,
            width: widget.isSelected ? 2 : 1,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: widget.isSelected
                    ? AppTheme.backgroundDark
                    : AppTheme.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            if (widget.onSwipeUp != null || widget.onSwipeDown != null)
              Text(
                '👆👇',
                style: TextStyle(
                  fontSize: 10,
                  color: widget.isSelected
                      ? AppTheme.backgroundDark
                      : AppTheme.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
