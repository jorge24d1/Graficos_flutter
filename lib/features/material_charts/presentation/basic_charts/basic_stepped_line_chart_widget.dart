import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicSteppedLineChartWidget extends StatefulWidget {
  final List<BasicChartDataPoint>? data;
  const MaterialChartsBasicSteppedLineChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicSteppedLineChartWidget> createState() =>
      _MaterialChartsBasicSteppedLineChartWidgetState();
}

class _MaterialChartsBasicSteppedLineChartWidgetState
    extends State<MaterialChartsBasicSteppedLineChartWidget> {
  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ??
        MaterialChartsMockDatasource().getSteppedLineChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Escalones (Stepped Line)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 40),
                  painter: _SteppedLinePainter(
                    data: chartData,
                    color: theme.colorScheme.primary,
                    gridColor: theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(chartData.length, (index) {
                  final item = chartData[index];
                  return Text(
                    item.label,
                    style: theme.textTheme.labelSmall,
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

class _SteppedLinePainter extends CustomPainter {
  final List<BasicChartDataPoint> data;
  final Color color;
  final Color gridColor;

  _SteppedLinePainter({
    required this.data,
    required this.color,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final maxY = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final stepX = size.width / (data.length - 1);

    final List<Offset> points = [];

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final normalizedY = data[i].value / maxY;
      final y = size.height - (normalizedY * (size.height - 20));
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      path.lineTo(next.dx, current.dy); // Horizontal step
      path.lineTo(next.dx, next.dy); // Vertical step
    }

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = color;
    for (var pt in points) {
      canvas.drawCircle(pt, 4.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SteppedLinePainter oldDelegate) =>
      oldDelegate.data != data;
}
