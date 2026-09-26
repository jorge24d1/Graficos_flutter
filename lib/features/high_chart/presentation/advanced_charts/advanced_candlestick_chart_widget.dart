import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartAdvancedCandlestickChartWidget extends StatelessWidget {
  const HighChartAdvancedCandlestickChartWidget({super.key});

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

        return HighchartsWidget(options: options);
      },
    );
  }
}
