import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicBubbleChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicBubbleChartWidget({
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
              title: 'Gráfico de Burbujas Multidimensional',
              description:
                  'Extiende el plano de dispersión incorporando el diámetro o área de cada marcador como una tercera variable cuantitativa (Z), permitiendo correlacionar tres dimensiones de datos en un solo gráfico.',
              useCases:
                  'Es idóneo para matrices de evaluación multidimensional de talento o proyectos: correlaciona simultáneamente volumen de ventas (eje X), porcentaje de satisfacción al cliente (eje Y) y peso relativo del colaborador (eje Z).',
              interpretation:
                  'Permite clasificar a las entidades en cuadrantes estratégicos: identifica a los colaboradores de alto rendimiento integral (altas ventas y satisfacción con gran tamaño de burbuja) frente a aquellos que ameritan coaching o revisión.',
              icon: Icons.bubble_chart_rounded,
            ),
          ],
        );
      },
    );
  }
}