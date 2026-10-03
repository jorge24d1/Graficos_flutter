import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicBarChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicBarChartWidget({
    super.key,
    this.showDescription = true,
  });

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

        final ventasCiudades =
            snapshot.data!['ventas_ciudades'] as List<dynamic>;

        final ciudades =
            ventasCiudades.map((e) => e['ciudad'] as String).toList();
        final ventas =
            ventasCiudades.map((e) => e['ventas'] as int).toList();

        final options = {
          'chart': {'type': 'bar', 'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas por Ciudad'},
          'xAxis': {
            'categories': ciudades,
            'title': {'text': null},
          },
          'yAxis': {
            'title': {'text': 'Ventas (COP)'},
          },
          'series': [
            {'name': 'Ventas', 'data': ventas, 'color': '#2E86DE'},
          ],
          'legend': {'enabled': false},
          'credits': {'enabled': false},
        };

        final chartWidget = HighchartsWidget(options: options);

        if (!showDescription) {
          return chartWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            chartWidget,
            const HighChartDescriptionCard(
              title: 'Gráfico de Barras Horizontales',
              description:
                  'Representa datos cuantitativos mediante barras rectangulares horizontales cuya longitud es proporcional al valor de cada categoría, facilitando la comparación entre elementos independientes.',
              useCases:
                  'Es ideal para comparar métricas numéricas discretas (como ventas por ciudad, inventario por sucursal o desempeño individual) especialmente cuando los nombres de las categorías son largos o se desea ordenar de mayor a menor jerarquía.',
              interpretation:
                  'Permite identificar de un solo vistazo qué ciudades o categorías lideran la facturación, cuáles presentan menor desempeño y estimar la magnitud de las brechas comerciales entre cada una.',
              icon: Icons.bar_chart_rounded,
            ),
          ],
        );
      },
    );
  }
}
