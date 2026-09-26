import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicDonutChartWidget extends StatelessWidget {
  const HighChartBasicDonutChartWidget({super.key});

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

        final ventasCategorias =
            snapshot.data!['ventas_categorias'] as List<dynamic>;

        final data = ventasCategorias.map((e) {
          return {'name': e['categoria'], 'y': e['ventas']};
        }).toList();

        final options = {
          'chart': {'type': 'pie', 'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas por Categoría'},
          'plotOptions': {
            'pie': {
              // El "innerSize" es lo que convierte el pie en donut
              'innerSize': '60%',
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