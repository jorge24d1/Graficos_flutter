import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedHeatmapChartWidget extends StatelessWidget {
  final List<HeatmapDataPoint>? data;
  const MaterialChartsAdvancedHeatmapChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final chartData = data ??
        MaterialChartsMockDatasource().getHeatmapChartData();
    final theme = Theme.of(context);

    final hours = ['08:00', '11:00', '14:00', '17:00', '20:00'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Gráfico Mapa de Calor (Heatmap)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: hours.length,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: chartData.length,
              itemBuilder: (context, index) {
                final item = chartData[index];
                final color = Color.lerp(
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.primary,
                  item.intensity,
                )!;

                return Tooltip(
                  message: '${item.xLabel} ${item.yLabel}: ${(item.intensity * 100).toInt()}%',
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${(item.intensity * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: item.intensity > 0.6
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
