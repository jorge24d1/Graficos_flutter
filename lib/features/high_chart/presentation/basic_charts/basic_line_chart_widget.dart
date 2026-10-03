import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicLineChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicLineChartWidget({
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

        final chartWidget = HighchartsWidget(options: options);

        if (!showDescription) {
          return chartWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            chartWidget,
            const HighChartDescriptionCard(
              title: 'Gráfico de Líneas Continuas',
              description:
                  'Conecta observaciones continuas sucesivas mediante segmentos rectos a lo largo de una secuencia ordenada, ilustrando la trayectoria y evolución de una variable en el tiempo.',
              useCases:
                  'Es fundamental en series temporales para monitorear variables continuas (como variaciones de temperatura por hora, fluctuaciones bursátiles, visitas web o consumo energético a lo largo de una jornada).',
              interpretation:
                  'Permite identificar la dirección y fuerza de la tendencia (ascendente, descendente o estable), detectar momentos exactos de inflexión, picos máximos, caídas abruptas y patrones cíclicos periódicos.',
              icon: Icons.show_chart_rounded,
            ),
          ],
        );
      },
    );
  }
}
