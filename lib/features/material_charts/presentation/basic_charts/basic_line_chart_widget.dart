import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicLineChartWidget extends StatefulWidget {
  final List<BasicChartDataPoint>? data;
  const MaterialChartsBasicLineChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicLineChartWidget> createState() =>
      _MaterialChartsBasicLineChartWidgetState();
}

class _MaterialChartsBasicLineChartWidgetState
    extends State<MaterialChartsBasicLineChartWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final chartData =
        widget.data ?? MaterialChartsMockDatasource().getLineChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Líneas Material',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 40),
                  painter: _LineChartPainter(
                    data: chartData,
                    lineColor: theme.colorScheme.primary,
                    pointColor: theme.colorScheme.secondary,
                    gridColor: theme.colorScheme.outlineVariant,
                    textColor: theme.colorScheme.onSurface,
                    hoveredIndex: hoveredIndex,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(chartData.length, (index) {
                  final item = chartData[index];
                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = index),
                    onExit: (_) => setState(() => hoveredIndex = null),
                    child: Text(
                      item.label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: hoveredIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: hoveredIndex == index
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<BasicChartDataPoint> data;
  final Color lineColor;
  final Color pointColor;
  final Color gridColor;
  final Color textColor;
  final int? hoveredIndex;

  _LineChartPainter({
    required this.data,
    required this.lineColor,
    required this.pointColor,
    required this.gridColor,
    required this.textColor,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double minY = data.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final double maxY = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final double rangeY = (maxY - minY) == 0 ? 1.0 : (maxY - minY);

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Grid lines
    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final double stepX = size.width / (data.length - 1);
    final List<Offset> points = [];

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final normalizedY = (data[i].value - minY) / rangeY;
      final y = size.height - (normalizedY * (size.height - 20) + 10);
      points.add(Offset(x, y));
    }

    // Line Path
    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    // Points
    final dotPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final isHovered = hoveredIndex == i;
      dotPaint.color = isHovered ? pointColor : lineColor;
      final radius = isHovered ? 7.0 : 4.5;
      canvas.drawCircle(points[i], radius, dotPaint);

      if (isHovered) {
        final textSpan = TextSpan(
          text: '${data[i].value}',
          style: TextStyle(
            color: pointColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
        final tp = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(points[i].dx - tp.width / 2, points[i].dy - 22));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
}
