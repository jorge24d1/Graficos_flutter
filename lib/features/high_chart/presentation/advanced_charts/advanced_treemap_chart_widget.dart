import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartAdvancedTreemapChartWidget extends StatelessWidget {
  const HighChartAdvancedTreemapChartWidget({super.key});

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

        return HighchartsWidget(options: options, height: 360);
      },
    );
  }
}
