import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicScatterChartWidget extends StatefulWidget {
  final List<mock.ScatterBubbleDataPoint>? data;
  const MaterialChartsBasicScatterChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicScatterChartWidget> createState() =>
      _MaterialChartsBasicScatterChartWidgetState();
}

class _MaterialChartsBasicScatterChartWidgetState
    extends State<MaterialChartsBasicScatterChartWidget> {
  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ?? MaterialChartsMockDatasource().getScatterChartData();
    final chartData = rawData.map((e) => ChartData(label: e.label, value: e.y)).toList();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Gráfico de Dispersión (Simulado con MaterialChartLine)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Expanded(child: MaterialChartLine(data: chartData, width: 800, height: 400)),
        ],
      ),
    );
  }
}
