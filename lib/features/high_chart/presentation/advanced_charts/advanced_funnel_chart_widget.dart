import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedFunnelChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartAdvancedFunnelChartWidget({
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

        final data = conversionVentas.map((e) {
          return [e['etapa'], e['cantidad']];
        }).toList();

        final options = {
          'chart': {'type': 'funnel', 'backgroundColor': 'transparent'},
          'title': {'text': 'Embudo de Conversión de Ventas'},
          'plotOptions': {
            'funnel': {
              'dataLabels': {
                'enabled': true,
                'format': '<b>{point.name}</b>: {point.y}',
              },
              'neckWidth': '30%',
              'neckHeight': '25%',
            },
          },
          'series': [
            {'name': 'Cantidad', 'data': data},
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
              title: 'Gráfico de Embudo (Funnel de Ventas)',
              description:
                  'Representa etapas progresivas y secuenciales de un proceso comercial mediante secciones cónicas decrecientes, donde el ancho de cada segmento ilustra el volumen que avanza a la siguiente fase.',
              useCases:
                  'Es el pilar analítico en marketing digital, comercio electrónico y pipelines de ventas B2B/B2C para medir la tasa de conversión desde las visitas iniciales hasta la confirmación de la compra.',
              interpretation:
                  'Permite identificar con precisión milimétrica los cuellos de botella y etapas con mayor deserción o pérdida de prospectos (como el abandono entre el carrito y el checkout), orientando esfuerzos de optimización de UX y fidelización.',
              icon: Icons.filter_alt_rounded,
            ),
          ],
        );
      },
    );
  }
}
