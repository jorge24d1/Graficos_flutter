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
    
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico Mapa de Calor (Simulado con MaterialBarChart)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 6),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final filteredData = rawData.length > 6 ? rawData.take(6).toList() : rawData;
                final chartData = filteredData.map((e) => BarChartData(label: '${e.xLabel} ${e.yLabel}', value: e.intensity * 100)).toList();
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