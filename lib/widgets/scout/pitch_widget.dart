import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Interactive pitch/field widget for setting event locations
class PitchWidget extends StatefulWidget {
  final double pitchX;
  final double pitchY;
  final Function(double, double) onLocationSelected;
  final bool interactive;

  const PitchWidget({
    Key? key,
    this.pitchX = 0.5,
    this.pitchY = 0.5,
    required this.onLocationSelected,
    this.interactive = true,
  }) : super(key: key);

  @override
  State<PitchWidget> createState() => _PitchWidgetState();
}

class _PitchWidgetState extends State<PitchWidget> {
  late double currentX;
  late double currentY;

  @override
  void initState() {
    super.initState();
    currentX = widget.pitchX;
    currentY = widget.pitchY;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.interactive ? _handleTap : null,
      child: Container(
        color: const Color(0xFF1B5E20),
        child: Stack(
          children: [
            // Pitch lines
            CustomPaint(
              painter: PitchPainter(),
              child: Container(),
            ),
            // Location marker
            Positioned(
              left: currentX * (MediaQuery.of(context).size.width - 32),
              top: currentY * (MediaQuery.of(context).size.height * 0.4 - 32),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.textPrimary,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppTheme.backgroundDark,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(TapDownDetails details) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.4;

    setState(() {
      currentX = (details.localPosition.dx / width).clamp(0.0, 1.0);
      currentY = (details.localPosition.dy / height).clamp(0.0, 1.0);
    });

    widget.onLocationSelected(currentX, currentY);
  }
}

/// Custom painter for pitch lines
class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const lineColor = Color(0xFFFFFFFF);
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    // Center line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      linePaint,
    );

    // Center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height / 6,
      linePaint..style = PaintingStyle.stroke,
    );

    // Center spot
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      2,
      Paint()..color = lineColor,
    );
  }

  @override
  bool shouldRepaint(PitchPainter oldDelegate) => false;
}
