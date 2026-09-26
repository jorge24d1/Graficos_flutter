import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicRadarChartWidget extends StatelessWidget {
  const HighChartBasicRadarChartWidget({super.key});

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

        final rendimiento = snapshot.data!['rendimiento'] as List<dynamic>;

        final empleados =
            rendimiento.map((e) => e['empleado'] as String).toList();
        final ventas = rendimiento.map((e) => e['ventas'] as int).toList();
        final satisfaccion =
            rendimiento.map((e) => e['satisfaccion'] as int).toList();

        // Un radar en Highcharts es un chart "polar" (necesita
        // highcharts-more.js, ya incluido).
        final options = {
          'chart': {
            'polar': true,
            'type': 'line',
            'backgroundColor': 'transparent',
          },
          'title': {'text': 'Rendimiento por Empleado'},
          'xAxis': {
            'categories': empleados,
            'tickmarkPlacement': 'on',
            'lineWidth': 0,
          },
          'yAxis': {
            'gridLineInterpolation': 'polygon',
            'lineWidth': 0,
            'min': 0,
          },
          'series': [
            {'name': 'Ventas', 'data': ventas, 'pointPlacement': 'on'},
            {
              'name': 'Satisfacción',
              'data': satisfaccion,
              'pointPlacement': 'on',
            },
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}
