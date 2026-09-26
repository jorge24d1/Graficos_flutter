import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicBarChartWidget extends StatelessWidget {
  const HighChartBasicBarChartWidget({super.key});

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

        final ventasCiudades =
            snapshot.data!['ventas_ciudades'] as List<dynamic>;

        final ciudades =
            ventasCiudades.map((e) => e['ciudad'] as String).toList();
        final ventas =
            ventasCiudades.map((e) => e['ventas'] as int).toList();

        final options = {
          'chart': {'type': 'bar', 'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas por Ciudad'},
          'xAxis': {
            'categories': ciudades,
            'title': {'text': null},
          },
          'yAxis': {
            'title': {'text': 'Ventas (COP)'},
          },
          'series': [
            {'name': 'Ventas', 'data': ventas, 'color': '#2E86DE'},
          ],
          'legend': {'enabled': false},
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}
