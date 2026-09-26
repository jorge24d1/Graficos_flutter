import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartAdvancedCombinedMultiAxisChartWidget extends StatelessWidget {
  const HighChartAdvancedCombinedMultiAxisChartWidget({super.key});

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
        final clientes =
            ventasMensuales.map((e) => e['clientes'] as int).toList();

        final options = {
          'chart': {'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas, Meta y Clientes por Mes'},
          'xAxis': {'categories': meses},
          // Dos ejes Y: uno para dinero (ventas/meta) y otro para
          // cantidad de clientes, ya que están en escalas muy distintas.
          'yAxis': [
            {
              // Eje primario (izquierda)
              'title': {'text': 'Ventas (COP)'},
            },
            {
              // Eje secundario (derecha)
              'title': {'text': 'Clientes'},
              'opposite': true,
            },
          ],
          'series': [
            {
              'name': 'Ventas',
              'type': 'column',
              'yAxis': 0,
              'data': ventas,
              'color': '#2E86DE',
            },
            {
              'name': 'Meta',
              'type': 'line',
              'yAxis': 0,
              'data': metas,
              'color': '#EE5253',
            },
            {
              'name': 'Clientes',
              'type': 'line',
              'yAxis': 1,
              'data': clientes,
              'color': '#2ECC71',
              'dashStyle': 'ShortDash',
            },
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options);
      },
    );
  }
}