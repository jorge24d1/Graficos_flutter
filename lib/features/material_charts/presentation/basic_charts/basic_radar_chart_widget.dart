import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicRadarChartWidget extends StatefulWidget {
  final List<RadarDataPoint>? data;
  const MaterialChartsBasicRadarChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicRadarChartWidget> createState() =>
      _MaterialChartsBasicRadarChartWidgetState();
}

class _MaterialChartsBasicRadarChartWidgetState
    extends State<MaterialChartsBasicRadarChartWidget> {
  @override
  Widget build(BuildContext context) {
    final chartData =
        widget.data ?? MaterialChartsMockDatasource().getRadarChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Gráfico Radial / Radar Material',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 20),
                  painter: _RadarChartPainter(
                    data: chartData,
                    color: theme.colorScheme.primary,
                    gridColor: theme.colorScheme.outlineVariant,
                    textColor: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<RadarDataPoint> data;
  final Color color;
  final Color gridColor;
  final Color textColor;

  _RadarChartPainter({
    required this.data,
    required this.color,
    required this.gridColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2.6;
    final int count = data.length;
    final angleStep = (2 * math.pi) / count;

    final gridPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Web concentric polygons
    for (int step = 1; step <= 4; step++) {
      final r = radius * (step / 4);
      final polygonPath = Path();
      for (int i = 0; i < count; i++) {
        final angle = i * angleStep - math.pi / 2;
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0) {
          polygonPath.moveTo(x, y);
        } else {
          polygonPath.lineTo(x, y);
        }
      }
      polygonPath.close();
      canvas.drawPath(polygonPath, gridPaint);
    }

    // Axis lines and labels
    for (int i = 0; i < count; i++) {
      final angle = i * angleStep - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), gridPaint);

      final labelX = center.dx + (radius + 18) * math.cos(angle);
      final labelY = center.dy + (radius + 18) * math.sin(angle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: data[i].attribute,
          style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
          canvas, Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2));
    }

    // Data polygon
    final dataPath = Path();
    for (int i = 0; i < count; i++) {
      final valueFactor = (data[i].value / data[i].maxValue).clamp(0.0, 1.0);
      final r = radius * valueFactor;
      final angle = i * angleStep - math.pi / 2;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _RadarChartPainter oldDelegate) =>
      oldDelegate.data != data;
}
