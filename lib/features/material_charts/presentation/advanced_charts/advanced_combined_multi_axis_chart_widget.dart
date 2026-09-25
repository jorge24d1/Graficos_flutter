import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedCombinedMultiAxisChartWidget
    extends StatefulWidget {
  final List<MultiAxisDataPoint>? data;
  const MaterialChartsAdvancedCombinedMultiAxisChartWidget({
    super.key,
    this.data,
  });

  @override
  State<MaterialChartsAdvancedCombinedMultiAxisChartWidget> createState() =>
      _MaterialChartsAdvancedCombinedMultiAxisChartWidgetState();
}

class _MaterialChartsAdvancedCombinedMultiAxisChartWidgetState
    extends State<MaterialChartsAdvancedCombinedMultiAxisChartWidget> {
  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ??
        MaterialChartsMockDatasource().getCombinedMultiAxisChartData();
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gráfico Combinado Multi-Eje (Barra + Línea)',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: theme.colorScheme.primary),
                      const SizedBox(width: 4),
                      const Text('Ventas (\$)', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 8),
                      Container(width: 10, height: 10, color: Colors.orange),
                      const SizedBox(width: 4),
                      const Text('Crecimiento (%)', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 40),
                  painter: _CombinedMultiAxisPainter(
                    data: chartData,
                    barColor: theme.colorScheme.primary,
                    lineColor: Colors.orange,
                    gridColor: theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(chartData.length, (index) {
                  return Text(
                    chartData[index].category,
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

class _CombinedMultiAxisPainter extends CustomPainter {
  final List<MultiAxisDataPoint> data;
  final Color barColor;
  final Color lineColor;
  final Color gridColor;

  _CombinedMultiAxisPainter({
    required this.data,
    required this.barColor,
    required this.lineColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxBar = data.map((e) => e.barValue).reduce((a, b) => a > b ? a : b);
    final maxLine = data.map((e) => e.lineValue).reduce((a, b) => a > b ? a : b);

    final stepX = size.width / data.length;
    final barWidth = (stepX * 0.45).clamp(16.0, 36.0);

    // Draw Bars (Axis 1)
    final barPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    final List<Offset> linePoints = [];

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final cx = (i * stepX) + stepX / 2;

      final barH = (item.barValue / maxBar) * (size.height - 20);
      final rect = Rect.fromLTRB(
        cx - barWidth / 2,
        size.height - barH,
        cx + barWidth / 2,
        size.height,
      );
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), barPaint);

      // Line point (Axis 2)
      final lineY = size.height - ((item.lineValue / maxLine) * (size.height - 30) + 10);
      linePoints.add(Offset(cx, lineY));
    }

    // Draw Line overlay
    final path = Path()..moveTo(linePoints[0].dx, linePoints[0].dy);
    for (int i = 1; i < linePoints.length; i++) {
      path.lineTo(linePoints[i].dx, linePoints[i].dy);
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = lineColor;
    for (var pt in linePoints) {
      canvas.drawCircle(pt, 4.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CombinedMultiAxisPainter oldDelegate) => true;
}
