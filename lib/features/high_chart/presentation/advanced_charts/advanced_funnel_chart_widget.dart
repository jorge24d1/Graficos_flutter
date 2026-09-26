import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartAdvancedFunnelChartWidget extends StatelessWidget {
  const HighChartAdvancedFunnelChartWidget({super.key});

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

        return HighchartsWidget(options: options);
      },
    );
  }
}
