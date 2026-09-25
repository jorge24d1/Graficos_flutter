import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicBubbleChartWidget extends StatefulWidget {
  final List<ScatterBubbleDataPoint>? data;
  const MaterialChartsBasicBubbleChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicBubbleChartWidget> createState() =>
      _MaterialChartsBasicBubbleChartWidgetState();
}

class _MaterialChartsBasicBubbleChartWidgetState
    extends State<MaterialChartsBasicBubbleChartWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final chartData =
        widget.data ?? MaterialChartsMockDatasource().getBubbleChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Burbujas (Bubble)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 20),
                  painter: _BubblePainter(
                    data: chartData,
                    primaryColor: theme.colorScheme.primary,
                    secondaryColor: theme.colorScheme.secondary,
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

class _BubblePainter extends CustomPainter {
  final List<ScatterBubbleDataPoint> data;
  final Color primaryColor;
  final Color secondaryColor;
  final Color gridColor;
  final int? hoveredIndex;

  _BubblePainter({
    required this.data,
    required this.primaryColor,
    required this.secondaryColor,
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
    }

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final px = (item.x / (maxX * 1.15)) * size.width;
      final py = size.height - ((item.y / (maxY * 1.15)) * size.height);
      final radius = item.size / 2.5;

      final isHovered = hoveredIndex == i;
      final bubblePaint = Paint()
        ..color = (i % 2 == 0 ? primaryColor : secondaryColor).withValues(alpha: isHovered ? 0.85 : 0.5)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(px, py), isHovered ? radius * 1.2 : radius, bubblePaint);

      final textSpan = TextSpan(
        text: item.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );
      final tp = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(px - tp.width / 2, py - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _BubblePainter oldDelegate) =>
      oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
}
