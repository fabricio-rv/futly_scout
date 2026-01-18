import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Mini pitch zones widget showing player activity zones
class MiniPitchZonesWidget extends StatelessWidget {
  final List<String> zones; // e.g., ['Direita', 'Centro', 'Esquerda']

  const MiniPitchZonesWidget({
    Key? key,
    required this.zones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Pitch background
          CustomPaint(
            painter: SimplePitchPainter(),
            child: Container(),
          ),
          // Zone indicators
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ZoneIndicator('Esq', zones.contains('Esquerda')),
                    _ZoneIndicator('Cent', zones.contains('Centro')),
                    _ZoneIndicator('Dir', zones.contains('Direita')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ZoneIndicator('Def', zones.contains('Defesa')),
                    _ZoneIndicator('Mei', zones.contains('Meio')),
                    _ZoneIndicator('Ata', zones.contains('Ataque')),
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

class _ZoneIndicator extends StatelessWidget {
  final String label;
  final bool active;

  const _ZoneIndicator(this.label, this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: active ? AppTheme.primaryGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: active ? AppTheme.primaryGreen : AppTheme.textSecondary,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color:
              active ? AppTheme.backgroundDark : AppTheme.textSecondary,
        ),
      ),
    );
  }
}

class SimplePitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const lineColor = Color(0xFFFFFFFF);
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 0.5;

    // Vertical center line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(SimplePitchPainter oldDelegate) => false;
}
