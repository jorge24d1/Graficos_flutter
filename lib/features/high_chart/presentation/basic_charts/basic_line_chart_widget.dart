import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicLineChartWidget extends StatelessWidget {
  const HighChartBasicLineChartWidget({super.key});

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

        final temperatura = snapshot.data!['temperatura'] as List<dynamic>;

        final horas = temperatura.map((e) => e['hora'] as String).toList();
        final temps =
            temperatura.map((e) => e['temperatura'] as int).toList();

        final options = {
          'chart': {'type': 'line', 'backgroundColor': 'transparent'},
          'title': {'text': 'Temperatura durante el día'},
          'xAxis': {
            'categories': horas,
            'title': {'text': 'Hora'},
          },
          'yAxis': {
            'title': {'text': 'Temperatura (°C)'},
          },
          'series': [
            {'name': 'Temperatura', 'data': temps, 'color': '#EE5253'},
          ],
          'legend': {'enabled': false},
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}
