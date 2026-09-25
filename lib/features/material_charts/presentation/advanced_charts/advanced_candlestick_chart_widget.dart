import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedCandlestickChartWidget extends StatefulWidget {
  final List<CandlestickDataPoint>? data;
  const MaterialChartsAdvancedCandlestickChartWidget({super.key, this.data});

  @override
  State<MaterialChartsAdvancedCandlestickChartWidget> createState() =>
      _MaterialChartsAdvancedCandlestickChartWidgetState();
}

class _MaterialChartsAdvancedCandlestickChartWidgetState
    extends State<MaterialChartsAdvancedCandlestickChartWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ??
        MaterialChartsMockDatasource().getCandlestickChartData();
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
                    'Gráfico de Velas Japonesas (Candlestick / OHLC)',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.green),
                      const SizedBox(width: 4),
                      const Text('Alcista', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 8),
                      Container(width: 10, height: 10, color: Colors.red),
                      const SizedBox(width: 4),
                      const Text('Bajista', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight - 30),
                  painter: _CandlestickPainter(
                    data: chartData,
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

class _CandlestickPainter extends CustomPainter {
  final List<CandlestickDataPoint> data;
  final Color gridColor;
  final int? hoveredIndex;

  _CandlestickPainter({
    required this.data,
    required this.gridColor,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    double minVal = data.first.low;
    double maxVal = data.first.high;
    for (var item in data) {
      if (item.low < minVal) minVal = item.low;
      if (item.high > maxVal) maxVal = item.high;
    }
    final range = (maxVal - minVal) == 0 ? 1.0 : (maxVal - minVal);

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 3; i++) {
      final y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final barWidth = (size.width / (data.length * 2)).clamp(12.0, 32.0);
    final stepX = size.width / data.length;

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final cx = (i * stepX) + stepX / 2;

      final yHigh = size.height - ((item.high - minVal) / range) * size.height;
      final yLow = size.height - ((item.low - minVal) / range) * size.height;
      final yOpen = size.height - ((item.open - minVal) / range) * size.height;
      final yClose = size.height - ((item.close - minVal) / range) * size.height;

      final color = item.isBullish ? Colors.green : Colors.red;
      final candlePaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      final wickPaint = Paint()
        ..color = color
        ..strokeWidth = 2.0;

      // Draw Wick (High to Low line)
      canvas.drawLine(Offset(cx, yHigh), Offset(cx, yLow), wickPaint);

      // Draw Candle Body (Open to Close rect)
      final top = item.isBullish ? yClose : yOpen;
      final bottom = item.isBullish ? yOpen : yClose;
      final rect = Rect.fromLTRB(
        cx - barWidth / 2,
        top,
        cx + barWidth / 2,
        bottom == top ? top + 2 : bottom,
      );

      canvas.drawRect(rect, candlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CandlestickPainter oldDelegate) =>
      oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
}
