import 'package:flutter/material.dart';

/// Heatmap widget showing where player was active on field
/// Uses Radial Gradients to simulate density/heat
class HeatmapWidget extends StatelessWidget {
  final List<Map<String, dynamic>> events; // {pitchX, pitchY, weight}

  const HeatmapWidget({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20), // Verde gramado escuro
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Stack(
            children: [
              // 1. O Campo (Pitch)
              SizedBox.expand(
                child: CustomPaint(
                  painter: PitchPainterHeatmap(),
                ),
              ),

              // 2. As "Manchas" de Calor
              // Usamos um Loop para desenhar cada ponto como um gradiente
              for (final event in events)
                Positioned(
                  // Centralizando a mancha no ponto exato (subtraímos metade do tamanho)
                  left: ((event['pitchX'] as double) * width) - 20,
                  top: ((event['pitchY'] as double) * height) - 20,
                  child: Container(
                    width: 40, // Mancha maior para espalhar o "calor"
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          // Centro "quente" (Amarelo forte com transparência)
                          Colors.yellowAccent.withOpacity(0.6),
                          // Borda suave (Transparente para mesclar com o fundo)
                          Colors.yellowAccent.withOpacity(0.0),
                        ],
                        stops: const [
                          0.2,
                          1.0
                        ], // O centro é forte, o resto espalha
                      ),
                    ),
                  ),
                ),

              // 3. (Opcional) Pontinho branco minúsculo no centro para precisão
              for (final event in events)
                Positioned(
                  left: ((event['pitchX'] as double) * width) - 2,
                  top: ((event['pitchY'] as double) * height) - 2,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Custom painter for pitch lines
class PitchPainterHeatmap extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const lineColor = Color(0xFFFFFFFF);
    final linePaint = Paint()
      ..color = lineColor.withOpacity(0.3) // Linhas mais discretas
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Retângulo do campo
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), linePaint);

    // Linha central
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      linePaint,
    );

    // Círculo central
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width * 0.1, linePaint);

    // Áreas (Simplificadas visualmente)
    // Grande área esquerda
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.2, size.width * 0.15, size.height * 0.6),
      linePaint,
    );

    // Grande área direita
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.85, size.height * 0.2, size.width * 0.15,
          size.height * 0.6),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(PitchPainterHeatmap oldDelegate) => false;
}
