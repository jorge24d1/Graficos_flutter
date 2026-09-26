import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicPieChartWidget extends StatelessWidget {
  const HighChartBasicPieChartWidget({super.key});

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

        final ventasPorVendedor =
            snapshot.data!['ventas_por_vendedor'] as List<dynamic>;

        final data = ventasPorVendedor.map((e) {
          return {'name': e['vendedor'], 'y': e['ventas']};
        }).toList();

        final options = {
          'chart': {'type': 'pie', 'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas por Vendedor'},
          'plotOptions': {
            'pie': {
              'dataLabels': {
                'enabled': true,
                'format': '{point.name}: {point.percentage:.1f}%',
              },
            },
          },
          'series': [
            {'name': 'Ventas', 'data': data},
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}