import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicRadarChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicRadarChartWidget({
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
              title: 'Gráfico de Radar / Polar (Spider Chart)',
              description:
                  'Dispone múltiples variables cuantitativas sobre ejes radiales que divergen desde un centro común, trazando formas poligonales que delimitan la huella o silueta general del desempeño.',
              useCases:
                  'Es óptimo para benchmarking de competencias profesionales, auditorías de calidad en productos, evaluación de madurez organizacional y comparación de múltiples KPIs entre distintos sujetos o equipos.',
              interpretation:
                  'Permite evaluar de inmediato la simetría y el equilibrio del perfil analizado: polígonos amplios y uniformes reflejan un rendimiento sólido e integral, mientras que vértices retraídos señalan debilidades o áreas críticas a fortalecer.',
              icon: Icons.radar_rounded,
            ),
          ],
        );
      },
    );
  }
}
