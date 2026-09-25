import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicPieChartWidget extends StatefulWidget {
  final List<BasicChartDataPoint>? data;
  final bool isDonut;
  const MaterialChartsBasicPieChartWidget({
    super.key,
    this.data,
    this.isDonut = false,
  });

  @override
  State<MaterialChartsBasicPieChartWidget> createState() =>
      _MaterialChartsBasicPieChartWidgetState();
}

class _MaterialChartsBasicPieChartWidgetState
    extends State<MaterialChartsBasicPieChartWidget> {
  int? hoveredIndex;

  static const List<Color> sliceColors = [
    Color(0xFF6750A4),
    Color(0xFF006874),
    Color(0xFF984061),
    Color(0xFF7D5260),
    Color(0xFF425E91),
    Color(0xFF705D00),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ??
        (widget.isDonut
            ? MaterialChartsMockDatasource().getDonutChartData()
            : MaterialChartsMockDatasource().getPieChartData());
    final theme = Theme.of(context);
    final total = chartData.fold<double>(0, (sum, e) => sum + e.value);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            widget.isDonut
                ? 'Gráfico Donas Material'
                : 'Gráfico Circular (Pie) Material',
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
                  painter: _PieChartPainter(
                    data: chartData,
                    total: total,
                    isDonut: widget.isDonut,
                    colors: sliceColors,
                    hoveredIndex: hoveredIndex,
                  ),
                ),
                if (widget.isDonut)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total',
                        style: theme.textTheme.labelMedium,
                      ),
                      Text(
                        '${total.toInt()}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(chartData.length, (index) {
              final item = chartData[index];
              final color = sliceColors[index % sliceColors.length];
              final percentage =
                  (total > 0 ? (item.value / total * 100) : 0).toStringAsFixed(1);

              return MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = index),
                onExit: (_) => setState(() => hoveredIndex = null),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: hoveredIndex == index
                        ? color.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${item.label} ($percentage%)',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: hoveredIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<BasicChartDataPoint> data;
  final double total;
  final bool isDonut;
  final List<Color> colors;
  final int? hoveredIndex;

  _PieChartPainter({
    required this.data,
    required this.total,
    required this.isDonut,
    required this.colors,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    double startAngle = -math.pi / 2;

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i].value / total) * 2 * math.pi;
      final isHovered = hoveredIndex == i;
      final drawRadius = isHovered ? radius * 1.05 : radius;

      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      if (isDonut) {
        final path = Path();
        final innerRadius = drawRadius * 0.55;
        path.arcTo(
            Rect.fromCircle(center: center, radius: drawRadius),
            startAngle,
            sweepAngle,
            false);
        path.arcTo(
            Rect.fromCircle(center: center, radius: innerRadius),
            startAngle + sweepAngle,
            -sweepAngle,
            false);
        canvas.drawPath(path, paint);
      } else {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: drawRadius),
          startAngle,
          sweepAngle,
          true,
          paint,
        );
      }

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _PieChartPainter oldDelegate) =>
      oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
}
