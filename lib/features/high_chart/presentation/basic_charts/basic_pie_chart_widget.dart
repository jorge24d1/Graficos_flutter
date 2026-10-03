import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicPieChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicPieChartWidget({
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
              title: 'Gráfico Circular / Pastel',
              description:
                  'Representa una cantidad total dividida en sectores angulares o rebanadas, donde el arco y la superficie de cada porción es proporcional a su contribución porcentual respecto al 100%.',
              useCases:
                  'Es óptimo para visualizar la cuota de participación o composición relativa de un conjunto pequeño de categorías mutuamente excluyentes (como ventas por vendedor, distribución presupuestaria o cuota de mercado).',
              interpretation:
                  'Facilita identificar qué vendedor o categoría posee la mayor dominancia en los resultados globales y evaluar si existe una alta concentración en pocos individuos o una contribución equilibrada en el equipo.',
              icon: Icons.pie_chart_outline_rounded,
            ),
          ],
        );
      },
    );
  }
}