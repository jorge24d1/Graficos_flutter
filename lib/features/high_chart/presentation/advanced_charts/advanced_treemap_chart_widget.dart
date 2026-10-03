import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedTreemapChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartAdvancedTreemapChartWidget({
    super.key,
    this.showDescription = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: HighChartDataService.loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(child: Text('Error cargando datos: ${snapshot.error}'));
        }

        final ventasProductos =
            snapshot.data!['ventas_productos'] as List<dynamic>;

        // Sacamos las categorías únicas para crear los nodos "padre"
        final categorias = ventasProductos
            .map((e) => e['categoria'] as String)
            .toSet()
            .toList();

        final data = <Map<String, dynamic>>[
          // Nodos padre: una "carpeta" por categoría, sin value propio
          // (Highcharts suma automáticamente el valor de sus hijos).
          for (final categoria in categorias)
            {'id': categoria, 'name': categoria},

          // Nodos hijos: cada producto, con su categoría como parent
          for (final producto in ventasProductos)
            {
              'name': producto['producto'],
              'parent': producto['categoria'],
              'value': producto['ventas'],
            },
        ];

        final options = {
          'chart': {'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas por Producto y Categoría'},
          'series': [
            {
              'type': 'treemap',
              'layoutAlgorithm': 'squarified',
              'allowTraversingTree': true,
              'data': data,
              'dataLabels': {
                'enabled': true,
              },
              'levels': [
                {
                  'level': 1,
                  'dataLabels': {'enabled': true},
                  'borderWidth': 3,
                },
              ],
            },
          ],
          'credits': {'enabled': false},
        };

        final chartWidget = HighchartsWidget(options: options, height: 360);

        if (!showDescription) {
          return chartWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            chartWidget,
            const HighChartDescriptionCard(
              title: 'Mapa de Árbol Jerárquico (Treemap)',
              description:
                  'Organiza datos con estructura jerárquica en rectángulos anidados agrupados por familias o categorías, donde la superficie espacial de cada bloque es proporcional a su contribución numérica al total.',
              useCases:
                  'Es óptimo para explorar catálogos masivos de productos organizados por departamentos, estructuras presupuestarias multi-nivel del sector público o privado, distribución de activos en portafolios y uso de almacenamiento digital.',
              interpretation:
                  'Permite dimensionar simultáneamente la jerarquía general entre categorías mayores y distinguir con rapidez qué producto específico lidera y dinamiza las ventas dentro de su respectivo subgrupo.',
              icon: Icons.dashboard_customize_rounded,
            ),
          ],
        );
      },
    );
  }
}
