import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicLineChartWidget extends StatefulWidget {
  final List<mock.BasicChartDataPoint>? data;
  const MaterialChartsBasicLineChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicLineChartWidget> createState() =>
      _MaterialChartsBasicLineChartWidgetState();
}

class _MaterialChartsBasicLineChartWidgetState
    extends State<MaterialChartsBasicLineChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ?? MaterialChartsMockDatasource().getLineChartData();
    final theme = Theme.of(context);

    final chartData = rawData.map((e) => ChartData(label: e.label, value: e.value)).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Líneas Material',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: MaterialChartLine(
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
