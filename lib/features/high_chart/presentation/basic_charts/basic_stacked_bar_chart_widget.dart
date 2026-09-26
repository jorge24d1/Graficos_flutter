import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicStackedBarChartWidget extends StatelessWidget {
  const HighChartBasicStackedBarChartWidget({super.key});

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

        final ventasDepartamentos =
            snapshot.data!['ventas_departamentos'] as List<dynamic>;

        final departamentos = ventasDepartamentos
            .map((e) => e['departamento'] as String)
            .toList();
        final online =
            ventasDepartamentos.map((e) => e['online'] as int).toList();
        final tienda =
            ventasDepartamentos.map((e) => e['tienda'] as int).toList();

        final options = {
          'chart': {'type': 'bar', 'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas por Departamento: Online vs Tienda'},
          'xAxis': {
            'categories': departamentos,
          },
          'yAxis': {
            'min': 0,
            'title': {'text': 'Unidades vendidas'},
          },
          'plotOptions': {
            'series': {
              'stacking': 'normal',
            },
          },
          'series': [
            {'name': 'Online', 'data': online, 'color': '#2E86DE'},
            {'name': 'Tienda', 'data': tienda, 'color': '#F5B041'},
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}
