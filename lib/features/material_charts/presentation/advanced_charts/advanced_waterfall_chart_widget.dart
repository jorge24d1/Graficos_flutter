import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedWaterfallChartWidget extends StatelessWidget {
  final List<WaterfallDataPoint>? data;
  const MaterialChartsAdvancedWaterfallChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final items =
        data ?? MaterialChartsMockDatasource().getWaterfallChartData();
    final theme = Theme.of(context);

    double cumulative = 0;
    final List<_WaterfallSegment> segments = [];

    for (var item in items) {
      if (item.isTotal) {
        segments.add(_WaterfallSegment(
          item: item,
          start: 0,
          end: item.amount,
        ));
      } else {
        final start = cumulative;
        cumulative += item.amount;
        segments.add(_WaterfallSegment(
          item: item,
          start: start,
          end: cumulative,
        ));
      }
    }

    final maxVal = 5500.0;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Gráfico Cascada (Waterfall)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(segments.length, (index) {
                    final seg = segments[index];
                    final isPositive = seg.item.amount >= 0;
                    final topVal = seg.start > seg.end ? seg.start : seg.end;
                    final botVal = seg.start < seg.end ? seg.start : seg.end;

                    final barHeight =
                        ((topVal - botVal) / maxVal) * (constraints.maxHeight * 0.7);
                    final bottomOffset =
                        (botVal / maxVal) * (constraints.maxHeight * 0.7);

                    final color = seg.item.isTotal
                        ? theme.colorScheme.primary
                        : (isPositive ? Colors.green : Colors.red);

                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${seg.item.amount.toInt()}',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Positioned(
                                  bottom: bottomOffset.clamp(0.0, constraints.maxHeight * 0.6),
                                  child: Container(
                                    width: 22,
                                    height: barHeight.clamp(4.0, constraints.maxHeight * 0.7),
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            seg.item.category,
                            style: const TextStyle(fontSize: 9),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WaterfallSegment {
  final WaterfallDataPoint item;
  final double start;
  final double end;

  _WaterfallSegment({
    required this.item,
    required this.start,
    required this.end,
  });
}
