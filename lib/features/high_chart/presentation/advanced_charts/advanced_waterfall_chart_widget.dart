import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartAdvancedWaterfallChartWidget extends StatelessWidget {
  const HighChartAdvancedWaterfallChartWidget({super.key});

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

        return HighchartsWidget(options: options);
      },
    );
  }
}