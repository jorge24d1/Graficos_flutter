import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsAdvancedHeatmapChartWidget extends StatelessWidget {
  final List<mock.HeatmapDataPoint>? data;
  const MaterialChartsAdvancedHeatmapChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final rawData = data ?? MaterialChartsMockDatasource().getHeatmapChartData();
    final chartData = rawData.map((e) => BarChartData(label: '${e.xLabel} ${e.yLabel}', value: e.intensity * 100)).toList();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico Mapa de Calor (Simulado con MaterialBarChart)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Expanded(child: MaterialBarChart(data: chartData, width: 800, height: 400)),
        ],
      ),
    );
  }
}
