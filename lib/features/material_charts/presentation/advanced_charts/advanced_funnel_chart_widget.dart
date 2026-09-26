import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsAdvancedFunnelChartWidget extends StatelessWidget {
  final List<mock.FunnelStageData>? data;
  const MaterialChartsAdvancedFunnelChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final rawData = data ?? MaterialChartsMockDatasource().getFunnelChartData();
    final chartData = rawData.map((e) => BarChartData(label: e.stage, value: e.value)).toList();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico Funnel (Simulado con MaterialBarChart)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Expanded(child: MaterialBarChart(data: chartData, width: 800, height: 400)),
        ],
      ),
    );
  }
}