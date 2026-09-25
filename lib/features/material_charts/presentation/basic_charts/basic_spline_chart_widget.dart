import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicSplineChartWidget extends StatefulWidget {
  final List<BasicChartDataPoint>? data;
  const MaterialChartsBasicSplineChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicSplineChartWidget> createState() =>
      _MaterialChartsBasicSplineChartWidgetState();
}

class _MaterialChartsBasicSplineChartWidgetState
    extends State<MaterialChartsBasicSplineChartWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final chartData =
        widget.data ?? MaterialChartsMockDatasource().getSplineChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico Spline / Curva Suave',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 40),
                  painter: _SplinePainter(
                    data: chartData,
                    color: theme.colorScheme.secondary,
                    gridColor: theme.colorScheme.outlineVariant,
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
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: hoveredIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
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

class _SplinePainter extends CustomPainter {
  final List<BasicChartDataPoint> data;
  final Color color;
  final Color gridColor;
  final int? hoveredIndex;

  _SplinePainter({
    required this.data,
    required this.color,
    required this.gridColor,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final maxY = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minY = data.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final rangeY = (maxY - minY) == 0 ? 1.0 : (maxY - minY);

    final stepX = size.width / (data.length - 1);
    final List<Offset> points = [];

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final normalizedY = (data[i].value - minY) / rangeY;
      final y = size.height - (normalizedY * (size.height - 20) + 10);
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + stepX / 2, p0.dy);
      final controlPoint2 = Offset(p1.dx - stepX / 2, p1.dy);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = color;
    for (int i = 0; i < points.length; i++) {
      final isHovered = hoveredIndex == i;
      canvas.drawCircle(points[i], isHovered ? 7.0 : 4.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SplinePainter oldDelegate) =>
      oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
}
