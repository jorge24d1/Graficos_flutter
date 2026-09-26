import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicAreaChartWidget extends StatelessWidget {
  const HighChartBasicAreaChartWidget({super.key});

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
        final ventas = ventasMensuales.map((e) => e['ventas'] as int).toList();
        final metas = ventasMensuales.map((e) => e['meta'] as int).toList();

        final options = {
          'chart': {'type': 'area', 'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas Mensuales'},
          'xAxis': {'categories': meses},
          'yAxis': {
            'title': {'text': 'Ventas (COP)'},
          },
          'series': [
            {'name': 'Ventas', 'data': ventas, 'color': '#2E86DE'},
            {'name': 'Meta', 'data': metas, 'color': '#EE5253'},
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}