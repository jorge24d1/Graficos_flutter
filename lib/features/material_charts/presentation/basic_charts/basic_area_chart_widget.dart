import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicAreaChartWidget extends StatefulWidget {
  final List<mock.BasicChartDataPoint>? data;
  const MaterialChartsBasicAreaChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicAreaChartWidget> createState() =>
      _MaterialChartsBasicAreaChartWidgetState();
}

class _MaterialChartsBasicAreaChartWidgetState
    extends State<MaterialChartsBasicAreaChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData =
        widget.data ?? MaterialChartsMockDatasource().getAreaChartData();
    final theme = Theme.of(context);
    
    final dataPoints = rawData.map((e) => AreaChartData(label: e.label, value: e.value)).toList();

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
                child: MaterialAreaChart(
                  series: [AreaChartSeries(name: 'Data', dataPoints: dataPoints)],
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
