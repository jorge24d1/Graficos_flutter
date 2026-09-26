import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicRadarChartWidget extends StatefulWidget {
  final List<mock.RadarDataPoint>? data;
  const MaterialChartsBasicRadarChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicRadarChartWidget> createState() => _MaterialChartsBasicRadarChartWidgetState();
}

class _MaterialChartsBasicRadarChartWidgetState extends State<MaterialChartsBasicRadarChartWidget> {
  static const List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal];
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ?? MaterialChartsMockDatasource().getRadarChartData();
    final chartData = List.generate(rawData.length, (index) => PieChartData(label: rawData[index].attribute, value: rawData[index].value, color: colors[index % colors.length]));
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Gráfico Radar (Simulado con MaterialPieChart)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Expanded(child: MaterialPieChart(data: chartData, width: 220, height: 220)),
        ],
      ),
    );
  }
}
