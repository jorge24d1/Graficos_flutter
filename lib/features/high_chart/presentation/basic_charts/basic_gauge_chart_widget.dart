import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicGaugeChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicGaugeChartWidget({
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

        final cumplimiento =
            snapshot.data!['cumplimiento'] as Map<String, dynamic>;
        final actual = cumplimiento['actual'];
        final meta = cumplimiento['meta'];

        final options = {
          'chart': {
            'type': 'gauge',
            'backgroundColor': 'transparent',
          },
          'title': {'text': 'Cumplimiento de Meta'},
          'pane': {
            'startAngle': -90,
            'endAngle': 89.9,
            'background': null,
            'center': ['50%', '75%'],
            'size': '110%',
          },
          'yAxis': {
            'min': 0,
            'max': 100,
            'tickPixelInterval': 40,
            'plotBands': [
              {'from': 0, 'to': 50, 'color': '#EE5253'},
              {'from': 50, 'to': 80, 'color': '#F5B041'},
              {'from': 80, 'to': 100, 'color': '#2ECC71'},
            ],
            // Línea marcando dónde está la meta
            'plotLines': [
              {
                'value': meta,
                'color': '#2E86DE',
                'width': 3,
                'zIndex': 5,
              },
            ],
          },
          'series': [
            {
              'name': 'Cumplimiento',
              'data': [actual],
              'dataLabels': {
                'format': '{y}%',
              },
            },
          ],
          'credits': {'enabled': false},
        };

        final chartWidget = HighchartsWidget(options: options, height: 320);

        if (!showDescription) {
          return chartWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            chartWidget,
            const HighChartDescriptionCard(
              title: 'Gráfico de Calibre / Tacómetro (Gauge Chart)',
              description:
                  'Emula el dial semicircular de un velocímetro o manómetro industrial con una aguja indicadora sobre franjas semaforizadas (rojo, amarillo, verde) que delimitan zonas cualitativas de desempeño.',
              useCases:
                  'Es el estándar por excelencia en dashboards de gestión estratégica y KPIs para monitorear el nivel de cumplimiento porcentual de metas comerciales, SLA de servicio, satisfacción al cliente o nivel de consumo.',
              interpretation:
                  'Proporciona una lectura diagnóstica inmediata: el usuario sabe en segundos si el indicador se encuentra en estado crítico (0-50%), en riesgo aceptable (50-80%) o en nivel óptimo de cumplimiento (80-100%), midiendo la distancia exacta frente a la línea de meta.',
              icon: Icons.speed_rounded,
            ),
          ],
        );
      },
    );
  }
}