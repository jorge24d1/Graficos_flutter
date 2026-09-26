import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsAdvancedTreemapChartWidget extends StatelessWidget {
  final List<mock.TreemapNode>? data;
  const MaterialChartsAdvancedTreemapChartWidget({super.key, this.data});

  static const List<Color> colors = [Color(0xFF6750A4), Color(0xFF006874), Color(0xFF984061), Color(0xFF7D5260), Color(0xFF425E91), Color(0xFF705D00)];

  @override
  Widget build(BuildContext context) {
    final rawData = data ?? MaterialChartsMockDatasource().getTreemapChartData();
    final chartData = List.generate(rawData.length, (index) => PieChartData(label: rawData[index].name, value: rawData[index].value, color: colors[index % colors.length]));
    
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text('Gráfico Treemap (Simulado con MaterialPieChart)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 6),
          Expanded(child: MaterialPieChart(data: chartData, width: 220, height: 220)),
        ],
      ),
    );
  }
}