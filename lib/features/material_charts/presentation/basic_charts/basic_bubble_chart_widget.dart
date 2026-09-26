import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicBubbleChartWidget extends StatefulWidget {
  final List<mock.ScatterBubbleDataPoint>? data;
  const MaterialChartsBasicBubbleChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicBubbleChartWidget> createState() => _MaterialChartsBasicBubbleChartWidgetState();
}

class _MaterialChartsBasicBubbleChartWidgetState extends State<MaterialChartsBasicBubbleChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ?? MaterialChartsMockDatasource().getBubbleChartData();
    final chartData = rawData.map((e) => BarChartData(label: e.label, value: e.y)).toList();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico Burbujas (Simulado con MaterialBarChart)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Expanded(child: MaterialBarChart(data: chartData, width: 800, height: 400)),
        ],
      ),
    );
  }
}