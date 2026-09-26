import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';

class MaterialChartsBasicGaugeChartWidget extends StatelessWidget {
  final double? value;
  const MaterialChartsBasicGaugeChartWidget({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    final gaugeValue =
        value ?? MaterialChartsMockDatasource().getGaugeChartValue();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Gráfico Calibre / Velocímetro (Gauge)',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: MaterialChartHollowSemiCircle(
              percentage: gaugeValue,
              size: 200,
              hollowRadius: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
