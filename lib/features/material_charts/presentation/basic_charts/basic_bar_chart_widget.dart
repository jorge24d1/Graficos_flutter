import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicBarChartWidget extends StatefulWidget {
  final List<mock.BasicChartDataPoint>? data;
  const MaterialChartsBasicBarChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicBarChartWidget> createState() =>
      _MaterialChartsBasicBarChartWidgetState();
}

class _MaterialChartsBasicBarChartWidgetState
    extends State<MaterialChartsBasicBarChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ?? MaterialChartsMockDatasource().getBarChartData();
    final theme = Theme.of(context);
    
    final chartData = rawData.map((e) => BarChartData(label: e.label, value: e.value)).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Barras Material',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: MaterialBarChart(
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
