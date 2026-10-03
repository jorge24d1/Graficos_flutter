import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsAdvancedCombinedMultiAxisChartWidget extends StatefulWidget {
  final List<mock.MultiAxisDataPoint>? data;
  const MaterialChartsAdvancedCombinedMultiAxisChartWidget({super.key, this.data});

  @override
  State<MaterialChartsAdvancedCombinedMultiAxisChartWidget> createState() => _MaterialChartsAdvancedCombinedMultiAxisChartWidgetState();
}

class _MaterialChartsAdvancedCombinedMultiAxisChartWidgetState extends State<MaterialChartsAdvancedCombinedMultiAxisChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ?? MaterialChartsMockDatasource().getCombinedMultiAxisChartData();
    final chartData = rawData.map((e) => BarChartData(label: e.category, value: e.barValue)).toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico Combinado (Simulado con MaterialBarChart)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 6),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return MaterialBarChart(
                  data: chartData,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}