import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicDonutChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicDonutChartWidget({
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
              title: 'Gráfico de Dona (Donut Chart)',
              description:
                  'Variante del gráfico circular con un orificio central en forma de anillo que reduce la distorsión del área interior y focaliza la atención en la longitud del arco perimetral de cada categoría.',
              useCases:
                  'Resulta ideal para categorizaciones de ingresos por línea de negocio, desglose de inventario por departamento o distribución de costos operativos, proporcionando un diseño limpio y moderno para paneles ejecutivos.',
              interpretation:
                  'Ayuda a discernir rápidamente qué líneas de producto generan la mayor proporción de ingresos y evaluar el grado de diversificación de la cartera comercial, identificando posibles dependencias.',
              icon: Icons.donut_large_rounded,
            ),
          ],
        );
      },
    );
  }
}