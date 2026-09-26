import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicSteppedLineChartWidget extends StatefulWidget {
  final List<mock.BasicChartDataPoint>? data;
  const MaterialChartsBasicSteppedLineChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicSteppedLineChartWidget> createState() => _MaterialChartsBasicSteppedLineChartWidgetState();
}

class _MaterialChartsBasicSteppedLineChartWidgetState extends State<MaterialChartsBasicSteppedLineChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ?? MaterialChartsMockDatasource().getSteppedLineChartData();
    final chartData = rawData.map((e) => ChartData(label: e.label, value: e.value)).toList();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico de Línea Escalonada (Simulado con MaterialChartLine)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Expanded(child: MaterialChartLine(data: chartData, width: 800, height: 400)),
        ],
      ),
    );
  }
}