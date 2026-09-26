import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartAdvancedHeatmapChartWidget extends StatelessWidget {
  const HighChartAdvancedHeatmapChartWidget({super.key});

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

        final horasActividad =
            snapshot.data!['horas_actividad'] as List<dynamic>;

        // Las horas son las claves del mapa, excluyendo "dia"
        const horas = ['08', '10', '12', '14', '16'];
        final dias = horasActividad.map((e) => e['dia'] as String).toList();

        // Heatmap espera puntos [xIndex, yIndex, valor]
        final data = <List<num>>[];
        for (var yIndex = 0; yIndex < horasActividad.length; yIndex++) {
          final Map<String, dynamic> fila =
              horasActividad[yIndex] as Map<String, dynamic>;
          for (var xIndex = 0; xIndex < horas.length; xIndex++) {
            final valor = fila[horas[xIndex]] as int;
            data.add([xIndex, yIndex, valor]);
          }
        }

        final options = {
          'chart': {'type': 'heatmap', 'backgroundColor': 'transparent'},
          'title': {'text': 'Actividad por Día y Hora'},
          'xAxis': {
            'categories': horas.map((h) => '$h:00').toList(),
          },
          'yAxis': {
            'categories': dias,
            'title': null,
            'reversed': true,
          },
          'colorAxis': {
            'min': 0,
            'minColor': '#FFFFFF',
            'maxColor': '#2E86DE',
          },
          'legend': {
            'align': 'right',
            'layout': 'vertical',
            'verticalAlign': 'top',
          },
          'series': [
            {
              'name': 'Actividad',
              'borderWidth': 1,
              'data': data,
              'dataLabels': {
                'enabled': true,
                'color': '#000000',
              },
            },
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options, height: 360);
      },
    );
  }
}
