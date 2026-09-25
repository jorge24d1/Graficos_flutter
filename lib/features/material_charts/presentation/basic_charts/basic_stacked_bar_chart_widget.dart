import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicStackedBarChartWidget extends StatefulWidget {
  final List<MultiSeriesChartDataPoint>? data;
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
    final chartData = widget.data ??
        MaterialChartsMockDatasource().getStackedBarChartData();
    final theme = Theme.of(context);

    double maxTotal = 0;
    for (var item in chartData) {
      double sum = item.values.fold(0, (a, b) => a + b);
      if (sum > maxTotal) maxTotal = sum;
    }

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(chartData.length, (index) {
                    final item = chartData[index];
                    final itemTotal = item.values.fold<double>(0, (a, b) => a + b);

                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: (itemTotal / maxTotal).clamp(0.05, 1.0),
                                widthFactor: 0.55,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: List.generate(item.values.length, (sIdx) {
                                      final val = item.values[sIdx];
                                      return Expanded(
                                        flex: (val * 100).toInt(),
                                        child: Container(
                                          color: seriesColors[sIdx % seriesColors.length],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: theme.textTheme.labelSmall?.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 4),
              if (chartData.isNotEmpty)
                Wrap(
                  spacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(chartData.first.seriesNames.length,
                      (sIdx) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          color: seriesColors[sIdx % seriesColors.length],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          chartData.first.seriesNames[sIdx],
                          style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                        ),
                      ],
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
