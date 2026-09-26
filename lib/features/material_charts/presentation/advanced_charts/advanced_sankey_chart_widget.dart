import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';

class MaterialChartsAdvancedSankeyChartWidget extends StatelessWidget {
  final Map<String, dynamic>? data;
  const MaterialChartsAdvancedSankeyChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final rawData = data ?? MaterialChartsMockDatasource().getSankeyChartData();
    final links = rawData['links'] as List<dynamic>;
    
    // We mock Sankey using a stacked bar chart of the links for visual presence
    final chartData = [
      StackedBarData(
        label: 'Flujos', 
        segments: links.map((l) => StackedBarSegment(value: (l.value as num).toDouble(), color: Colors.blue, label: '${l.sourceId}->${l.targetId}')).toList()
      )
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico Sankey (Simulado con MaterialStackedBarChart)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Expanded(child: MaterialStackedBarChart(data: chartData, width: 800, height: 400)),
        ],
      ),
    );
  }
}
