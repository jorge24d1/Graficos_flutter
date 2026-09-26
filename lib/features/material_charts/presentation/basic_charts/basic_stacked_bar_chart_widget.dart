import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicStackedBarChartWidget extends StatefulWidget {
  final List<mock.MultiSeriesChartDataPoint>? data;
  const MaterialChartsBasicStackedBarChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicStackedBarChartWidget> createState() =>
      _MaterialChartsBasicStackedBarChartWidgetState();
}

class _MaterialChartsBasicStackedBarChartWidgetState
    extends State<MaterialChartsBasicStackedBarChartWidget> {
  static const List<Color> seriesColors = [
    Color(0xFF6750A4),
    Color(0xFF006874),
    Color(0xFF984061),
  ];

  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ??
        MaterialChartsMockDatasource().getStackedBarChartData();
    final theme = Theme.of(context);

    final chartData = rawData.map((item) {
      final segments = List.generate(item.values.length, (sIdx) {
        return StackedBarSegment(
          value: item.values[sIdx],
          color: seriesColors[sIdx % seriesColors.length],
          label: item.seriesNames[sIdx],
        );
      });
      return StackedBarData(label: item.label, segments: segments);
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Barras Apiladas (Stacked)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: MaterialStackedBarChart(
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