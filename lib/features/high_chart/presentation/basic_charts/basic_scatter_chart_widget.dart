import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicScatterChartWidget extends StatelessWidget {
  const HighChartBasicScatterChartWidget({super.key});

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

        final edadSalario = snapshot.data!['edad_salario'] as List<dynamic>;

        final data = edadSalario.map((e) {
          return [e['edad'], e['salario']];
        }).toList();

        final options = {
          'chart': {'type': 'scatter', 'backgroundColor': 'transparent'},
          'title': {'text': 'Edad vs Salario'},
          'xAxis': {
            'title': {'text': 'Edad'},
          },
          'yAxis': {
            'title': {'text': 'Salario (COP)'},
          },
          'series': [
            {
              'name': 'Empleados',
              'data': data,
              'color': '#2E86DE',
              'marker': {'radius': 5},
            },
          ],
          'legend': {'enabled': false},
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}
