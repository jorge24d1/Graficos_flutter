import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsBasicBarChartWidget extends StatefulWidget {
  final List<BasicChartDataPoint>? data;
  const MaterialChartsBasicBarChartWidget({super.key, this.data});

  @override
  State<MaterialChartsBasicBarChartWidget> createState() =>
      _MaterialChartsBasicBarChartWidgetState();
}

class _MaterialChartsBasicBarChartWidgetState
    extends State<MaterialChartsBasicBarChartWidget> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final chartData =
        widget.data ?? MaterialChartsMockDatasource().getBarChartData();
    final theme = Theme.of(context);
    final maxValue = chartData.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gráfico de Barras Material',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(chartData.length, (index) {
                    final item = chartData[index];
                    final heightFactor = (item.value / maxValue).clamp(0.05, 1.0);
                    final isHovered = touchedIndex == index;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            touchedIndex = isHovered ? null : index;
                          });
                        },
                        child: MouseRegion(
                          onEnter: (_) => setState(() => touchedIndex = index),
                          onExit: (_) => setState(() => touchedIndex = null),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isHovered
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${item.value.toInt()}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isHovered
                                        ? theme.colorScheme.onPrimary
                                        : theme.colorScheme.onSurface,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: FractionallySizedBox(
                                    heightFactor: heightFactor,
                                    widthFactor: 0.6,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      decoration: BoxDecoration(
                                        color: isHovered
                                            ? theme.colorScheme.secondary
                                            : theme.colorScheme.primary,
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(6),
                                        ),
                                        boxShadow: isHovered
                                            ? [
                                                BoxShadow(
                                                  color: theme.colorScheme.primary
                                                      .withValues(alpha: 0.4),
                                                  blurRadius: 8,
                                                  spreadRadius: 1,
                                                )
                                              ]
                                            : [],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.label,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontSize: 11,
                                  fontWeight: isHovered
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
