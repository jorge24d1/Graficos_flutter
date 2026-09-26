import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicSteppedLineChartWidget extends StatelessWidget {
  const HighChartBasicSteppedLineChartWidget({super.key});

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

        return HighchartsWidget(options: options);
      },
    );
  }
}
