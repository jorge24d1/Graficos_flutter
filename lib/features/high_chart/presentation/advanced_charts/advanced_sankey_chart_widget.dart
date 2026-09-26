import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartAdvancedSankeyChartWidget extends StatelessWidget {
  const HighChartAdvancedSankeyChartWidget({super.key});

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

        final flujoClientes =
            snapshot.data!['flujo_clientes'] as List<dynamic>;

        // Sankey espera [origen, destino, peso] por cada punto
        final data = flujoClientes.map((e) {
          return [e['origen'], e['destino'], e['cantidad']];
        }).toList();

        final options = {
          'chart': {'backgroundColor': 'transparent'},
          'title': {'text': 'Flujo de Clientes'},
          'series': [
            {
              'keys': ['from', 'to', 'weight'],
              'data': data,
              'type': 'sankey',
              'name': 'Flujo de Clientes',
            },
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options, height: 360);
      },
    );
  }
}
