import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedTreemapChartWidget extends StatelessWidget {
  final List<TreemapNode>? data;
  const MaterialChartsAdvancedTreemapChartWidget({super.key, this.data});

  static const List<Color> treemapColors = [
    Color(0xFF6750A4),
    Color(0xFF006874),
    Color(0xFF984061),
    Color(0xFF7D5260),
    Color(0xFF425E91),
    Color(0xFF705D00),
  ];

  @override
  Widget build(BuildContext context) {
    final nodes =
        data ?? MaterialChartsMockDatasource().getTreemapChartData();
    final theme = Theme.of(context);
    final totalValue = nodes.fold<double>(0, (sum, n) => sum + n.value);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Gráfico Mapas del Árbol (Treemap)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: List.generate(nodes.length, (index) {
                      final node = nodes[index];
                      final flexRatio = node.value / totalValue;
                      final cardWidth =
                          (constraints.maxWidth * flexRatio * 1.8).clamp(80.0, constraints.maxWidth);

                      return Container(
                        width: cardWidth,
                        height: 55,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: treemapColors[index % treemapColors.length],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              node.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${node.value.toInt()}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
