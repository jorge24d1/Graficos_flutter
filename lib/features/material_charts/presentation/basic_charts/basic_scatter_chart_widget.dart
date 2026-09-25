import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicScatterChartWidget extends StatefulWidget {
  final List<ScatterBubbleDataPoint>? data;
  const MaterialChartsBasicScatterChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicScatterChartWidget> createState() =>
      _MaterialChartsBasicScatterChartWidgetState();
}

class _MaterialChartsBasicScatterChartWidgetState
    extends State<MaterialChartsBasicScatterChartWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final chartData =
        widget.data ?? MaterialChartsMockDatasource().getScatterChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Dispersión (Scatter)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 20),
                  painter: _ScatterPainter(
                    data: chartData,
                    color: theme.colorScheme.tertiary,
                    gridColor: theme.colorScheme.outlineVariant,
                    hoveredIndex: hoveredIndex,
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

class _ScatterPainter extends CustomPainter {
  final List<ScatterBubbleDataPoint> data;
  final Color color;
  final Color gridColor;
  final int? hoveredIndex;

  _ScatterPainter({
    required this.data,
    required this.color,
    required this.gridColor,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxX = data.map((e) => e.x).reduce((a, b) => a > b ? a : b);
    final maxY = data.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      final x = size.width * (i / 4);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final pointPaint = Paint()..color = color;

    for (int i = 0; i < data.length; i++) {
      final px = (data[i].x / (maxX * 1.1)) * size.width;
      final py = size.height - ((data[i].y / (maxY * 1.1)) * size.height);
      final isHovered = hoveredIndex == i;

      canvas.drawCircle(Offset(px, py), isHovered ? 9.0 : 6.0, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScatterPainter oldDelegate) =>
      oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
}
