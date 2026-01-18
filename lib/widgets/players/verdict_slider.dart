import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Verdict slider widget for comparison decisions
class VerdictSlider extends StatefulWidget {
  final String label;
  final ValueChanged<int> onChanged;
  final int initialValue;

  const VerdictSlider({
    Key? key,
    required this.label,
    required this.onChanged,
    this.initialValue = 50,
  }) : super(key: key);

  @override
  State<VerdictSlider> createState() => _VerdictSliderState();
}

class _VerdictSliderState extends State<VerdictSlider> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              'A',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            Expanded(
              child: Slider(
                value: currentValue.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: AppTheme.primaryGreen,
                inactiveColor: AppTheme.surfaceDark,
                onChanged: (value) {
                  setState(() {
                    currentValue = value.toInt();
                    widget.onChanged(currentValue);
                  });
                },
              ),
            ),
            const Text(
              'B',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.errorRed,
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            currentValue == 50 ? 'Empate' : (currentValue > 50 ? 'Vantagem A' : 'Vantagem B'),
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
