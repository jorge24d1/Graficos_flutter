import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsAdvancedCandlestickChartWidget extends StatefulWidget {
  final List<mock.CandlestickDataPoint>? data;
  const MaterialChartsAdvancedCandlestickChartWidget({super.key, this.data});

  @override
  State<MaterialChartsAdvancedCandlestickChartWidget> createState() =>
      _MaterialChartsAdvancedCandlestickChartWidgetState();
}

class _MaterialChartsAdvancedCandlestickChartWidgetState
    extends State<MaterialChartsAdvancedCandlestickChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ??
        MaterialChartsMockDatasource().getCandlestickChartData();
    final theme = Theme.of(context);

    final chartData = rawData.map((e) => CandlestickData(
      date: e.date,
      open: e.open,
      high: e.high,
      low: e.low,
      close: e.close,
    )).toList();

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
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: MaterialCandlestickChart(
                  data: chartData,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight - 40,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
