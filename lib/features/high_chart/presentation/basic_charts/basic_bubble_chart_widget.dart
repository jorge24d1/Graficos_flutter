import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicBubbleChartWidget extends StatelessWidget {
  const HighChartBasicBubbleChartWidget({super.key});

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

        // x: ventas, y: satisfacción, z: tamaño de burbuja (usamos ventas
        // otra vez, ya que el JSON no trae una tercera métrica numérica
        // independiente para este dataset).
        final data = rendimiento.map((e) {
          return {
            'name': e['empleado'],
            'x': e['ventas'],
            'y': e['satisfaccion'],
            'z': e['ventas'],
          };
        }).toList();

        final options = {
          'chart': {'type': 'bubble', 'backgroundColor': 'transparent'},
          'title': {'text': 'Rendimiento por Empleado'},
          'xAxis': {
            'title': {'text': 'Ventas'},
          },
          'yAxis': {
            'title': {'text': 'Satisfacción (%)'},
          },
          'series': [
            {
              'name': 'Empleados',
              'data': data,
              'color': '#2E86DE',
            },
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}