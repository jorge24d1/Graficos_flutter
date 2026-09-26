import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart' as mock;

class MaterialChartsBasicPieChartWidget extends StatefulWidget {
  final List<mock.BasicChartDataPoint>? data;
  final bool isDonut;
  const MaterialChartsBasicPieChartWidget({
    super.key,
    this.data,
    this.isDonut = false,
  });

  @override
  State<MaterialChartsBasicPieChartWidget> createState() =>
      _MaterialChartsBasicPieChartWidgetState();
}

class _MaterialChartsBasicPieChartWidgetState
    extends State<MaterialChartsBasicPieChartWidget> {
  static const List<Color> sliceColors = [
    Color(0xFF6750A4),
    Color(0xFF006874),
    Color(0xFF984061),
    Color(0xFF7D5260),
    Color(0xFF425E91),
    Color(0xFF705D00),
  ];

  @override
  Widget build(BuildContext context) {
    final rawData = widget.data ??
        (widget.isDonut
            ? MaterialChartsMockDatasource().getDonutChartData()
            : MaterialChartsMockDatasource().getPieChartData());
    final theme = Theme.of(context);

    final chartData = List.generate(rawData.length, (index) {
      final e = rawData[index];
      return PieChartData(
        label: e.label,
        value: e.value,
        color: sliceColors[index % sliceColors.length],
      );
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            widget.isDonut
                ? 'Gráfico Donas Material'
                : 'Gráfico Circular (Pie) Material',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: MaterialPieChart(
              data: chartData,
              width: 220,
              height: 220,
            ),
          ),
        ],
      ),
    );
  }
}