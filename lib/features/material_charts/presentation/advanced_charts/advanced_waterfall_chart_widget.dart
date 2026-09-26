import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsAdvancedWaterfallChartWidget extends StatelessWidget {
  final List<mock.WaterfallDataPoint>? data;
  const MaterialChartsAdvancedWaterfallChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final rawData = data ?? MaterialChartsMockDatasource().getWaterfallChartData();
    final chartData = rawData.map((e) => BarChartData(label: e.category, value: e.amount.abs(), color: e.amount >= 0 ? Colors.green : Colors.red)).toList();
    
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico Waterfall (Simulado con MaterialBarChart)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 6),
          Expanded(child: MaterialBarChart(data: chartData, width: 800, height: 400)),
        ],
      ),
    );
  }
}