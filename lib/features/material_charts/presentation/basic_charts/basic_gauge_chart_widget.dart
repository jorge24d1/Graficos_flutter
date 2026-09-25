import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';

class MaterialChartsBasicGaugeChartWidget extends StatelessWidget {
  final double? value;
  const MaterialChartsBasicGaugeChartWidget({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    final gaugeValue =
        value ?? MaterialChartsMockDatasource().getGaugeChartValue();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Gráfico Calibre / Velocímetro (Gauge)',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(220, 220),
                  painter: _GaugePainter(
                    value: gaugeValue,
                    primaryColor: theme.colorScheme.primary,
                    bgColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Column(
                    children: [
                      Text(
                        '${gaugeValue.toStringAsFixed(1)}%',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Nivel de Eficiencia',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value; // 0 to 100
  final Color primaryColor;
  final Color bgColor;

  _GaugePainter({
    required this.value,
    required this.primaryColor,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 20);
    final radius = math.min(size.width, size.height) / 2.2;
    const startAngle = math.pi * 0.75;
    const sweepAngle = math.pi * 1.5;

    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    final valueSweep = (value / 100.0) * sweepAngle;

    final valPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      valueSweep,
      false,
      valPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.value != value;
}
