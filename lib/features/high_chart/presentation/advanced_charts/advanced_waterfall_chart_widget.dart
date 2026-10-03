import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedWaterfallChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartAdvancedWaterfallChartWidget({
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

        // El primer punto es el valor absoluto de arranque; los
        // siguientes son la caída (delta negativo) respecto al anterior;
        // el último se marca como "isSum" para mostrar el total final.
        final data = <Map<String, dynamic>>[];
        for (var i = 0; i < conversionVentas.length; i++) {
          final etapa = conversionVentas[i]['etapa'];
          final cantidad = conversionVentas[i]['cantidad'] as int;

          if (i == 0) {
            data.add({'name': etapa, 'y': cantidad});
          } else {
            final anterior = conversionVentas[i - 1]['cantidad'] as int;
            data.add({'name': etapa, 'y': cantidad - anterior});
          }
        }
        data.add({'name': 'Total', 'isSum': true});

        final options = {
          'chart': {'type': 'waterfall', 'backgroundColor': 'transparent'},
          'title': {'text': 'Caída en el Embudo de Ventas'},
          'xAxis': {'type': 'category'},
          'yAxis': {
            'title': {'text': 'Cantidad'},
          },
          'series': [
            {
              'name': 'Embudo',
              'data': data,
              'dataLabels': {'enabled': true},
              'upColor': '#2ECC71',
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
              title: 'Gráfico de Cascada (Waterfall / Puente Financiero)',
              description:
                  'Presenta columnas flotantes consecutivas que explican de forma secuencial cómo un valor inicial sufre adiciones positivas (verde) o deducciones negativas (rojo) hasta consolidar un valor neto o total final acumulado.',
              useCases:
                  'Es el estándar en informes financieros corporativos (desglose de ingresos brutos a EBITDA y utilidad neta), conciliaciones de inventario, auditorías de costos de producción y análisis secuencial de caídas en embudos de venta.',
              interpretation:
                  'Permite dimensionar el impacto individual y ponderado de cada factor intermedio en el balance global, identificando con nitidez qué evento, costo o etapa generó la mayor contracción o contribución sobre el resultado consolidado.',
              icon: Icons.waterfall_chart_rounded,
            ),
          ],
        );
      },
    );
  }
}