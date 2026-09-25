import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicAreaChartWidget extends StatefulWidget {
  final List<BasicChartDataPoint>? data;
  const MaterialChartsBasicAreaChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicAreaChartWidget> createState() =>
      _MaterialChartsBasicAreaChartWidgetState();
}

class _MaterialChartsBasicAreaChartWidgetState
    extends State<MaterialChartsBasicAreaChartWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final chartData =
        widget.data ?? MaterialChartsMockDatasource().getAreaChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Área Material',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 40),
                  painter: _AreaChartPainter(
                    data: chartData,
                    color: theme.colorScheme.primary,
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
                      style: theme.textTheme.labelMedium?.copyWith(
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

class _AreaChartPainter extends CustomPainter {
  final List<BasicChartDataPoint> data;
  final Color color;
  final Color gridColor;
  final int? hoveredIndex;

  _AreaChartPainter({
    required this.data,
    required this.color,
    required this.gridColor,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double maxY = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    final double stepX = size.width / (data.length - 1);
    final List<Offset> points = [];

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final normalizedY = data[i].value / maxY;
      final y = size.height - (normalizedY * (size.height - 20));
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final areaPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.5), color.withValues(alpha: 0.05)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(areaPath, fillPaint);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _AreaChartPainter oldDelegate) =>
      oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
}
