import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicSplineChartWidget extends StatelessWidget {
  const HighChartBasicSplineChartWidget({super.key});

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

        final ventasMensuales =
            snapshot.data!['ventas_mensuales'] as List<dynamic>;

        final meses = ventasMensuales.map((e) => e['mes'] as String).toList();
        final clientes =
            ventasMensuales.map((e) => e['clientes'] as int).toList();

        final options = {
          'chart': {'type': 'spline', 'backgroundColor': 'transparent'},
          'title': {'text': 'Clientes Nuevos por Mes'},
          'xAxis': {
            'categories': meses,
          },
          'yAxis': {
            'title': {'text': 'Clientes'},
          },
          'series': [
            {'name': 'Clientes', 'data': clientes, 'color': '#8E44AD'},
          ],
          'legend': {'enabled': false},
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}
