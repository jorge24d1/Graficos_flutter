import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedCandlestickChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartAdvancedCandlestickChartWidget({
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

        final data = snapshot.data!['precios_accion'] as List<dynamic>?;

        if (data == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Falta agregar "precios_accion" en graficos_data.json '
                '(fecha, apertura, maximo, minimo, cierre).',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Highcharts candlestick espera: [timestamp_ms, open, high, low, close]
        final ohlc = data.map((e) {
          final timestamp =
              DateTime.parse(e['fecha'] as String).millisecondsSinceEpoch;
          return [
            timestamp,
            e['apertura'],
            e['maximo'],
            e['minimo'],
            e['cierre'],
          ];
        }).toList();

        final options = {
          'chart': {'type': 'candlestick', 'backgroundColor': 'transparent'},
          'title': {'text': 'Precio de la Acción'},
          'xAxis': {'type': 'datetime'},
          'yAxis': {
            'title': {'text': 'Precio'},
          },
          'series': [
            {
              'name': 'Precio',
              'data': ohlc,
            },
          ],
          'rangeSelector': {'enabled': false},
          'navigator': {'enabled': false},
          'scrollbar': {'enabled': false},
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
              title: 'Gráfico de Velas Japonesas (Candlestick)',
              description:
                  'Visualización bursátil y financiera de alta precisión que sintetiza en cada barra cuatro cotizaciones clave: precio de apertura, máximo alcanzado, mínimo registrado y precio de cierre (OHLC) para cada período analizado.',
              useCases:
                  'Es el formato estándar e indispensable en trading de acciones, mercados de valores, divisas (Forex) y criptoactivos para estudiar la volatilidad de precios, liquidez y dinámicas de oferta y demanda.',
              interpretation:
                  'El cuerpo de la vela refleja la fuerza del impulso comprador o vendedor, mientras que las sombras o mechas superior e inferior revelan los niveles extremos de rechazo de precios, permitiendo predecir cambios o continuaciones de tendencia.',
              icon: Icons.candlestick_chart_rounded,
            ),
          ],
        );
      },
    );
  }
}
