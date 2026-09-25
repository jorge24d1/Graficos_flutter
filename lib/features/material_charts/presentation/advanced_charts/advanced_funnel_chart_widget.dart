import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedFunnelChartWidget extends StatelessWidget {
  final List<FunnelStageData>? data;
  const MaterialChartsAdvancedFunnelChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final stages =
        data ?? MaterialChartsMockDatasource().getFunnelChartData();
    final theme = Theme.of(context);
    final maxVal = stages.first.value;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Gráfico Embudos (Funnel Conversion)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(stages.length, (index) {
                final stage = stages[index];
                final widthRatio = stage.value / maxVal;

                return FractionallySizedBox(
                  widthFactor: widthRatio.clamp(0.2, 1.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color.lerp(
                        theme.colorScheme.primary,
                        theme.colorScheme.tertiary,
                        index / stages.length,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            stage.stage,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${stage.value.toInt()} (${stage.conversionPercentage}%)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
