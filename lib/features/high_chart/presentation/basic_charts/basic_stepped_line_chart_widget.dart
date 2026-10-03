import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicSteppedLineChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicSteppedLineChartWidget({
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

        final conversionVentas =
            snapshot.data!['conversion_ventas'] as List<dynamic>;

        final etapas =
            conversionVentas.map((e) => e['etapa'] as String).toList();
        final cantidades =
            conversionVentas.map((e) => e['cantidad'] as int).toList();

        final options = {
          'chart': {'type': 'line', 'backgroundColor': 'transparent'},
          'title': {'text': 'Embudo de Conversión'},
          'xAxis': {
            'categories': etapas,
          },
          'yAxis': {
            'title': {'text': 'Cantidad'},
          },
          'series': [
            {
              'name': 'Cantidad',
              'data': cantidades,
              // "step" es lo que convierte la línea normal en escalonada
              'step': 'left',
              'color': '#EE5253',
            },
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
              title: 'Gráfico de Línea Escalonada (Stepped Line)',
              description:
                  'Presenta variaciones mediante tramos horizontales planos conectados por saltos verticales en ángulo recto, manteniendo constante el valor hasta que ocurre una variación abrupta en la siguiente etapa.',
              useCases:
                  'Es idóneo para variables que cambian por saltos discretos o etapas bien definidas (como cantidades de usuarios a través de las fases de un proceso comercial, cambios de tasas arancelarias o niveles fijos de inventario).',
              interpretation:
                  'Permite constatar con claridad que entre una etapa y otra no existe una variación gradual, sino una caída discreta en el paso de transición, evidenciando exactamente el volumen de usuarios descartados entre hitos consecutivos.',
              icon: Icons.stairs_rounded,
            ),
          ],
        );
      },
    );
  }
}
