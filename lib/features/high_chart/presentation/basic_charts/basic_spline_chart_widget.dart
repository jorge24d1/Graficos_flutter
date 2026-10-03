import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicSplineChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicSplineChartWidget({
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
              title: 'Gráfico de Curva Suavizada (Spline)',
              description:
                  'Traza una curva armónica y continua que interpola matemáticamente los puntos de datos mediante polinomios cúbicos, eliminando las aristas angulares de las líneas rectas tradicionales.',
              useCases:
                  'Es perfecto para representar fenómenos orgánicos continuos y series de captación periódica (como el registro mensual de nuevos clientes, tráfico de usuarios únicos o tasas de retención).',
              interpretation:
                  'Permite interpretar visualmente la tasa de aceleración o desaceleración en el ritmo de crecimiento, facilitando un análisis panorámico de la inercia del negocio sin la distracción de quiebres geométricos pronunciados.',
              icon: Icons.timeline_rounded,
            ),
          ],
        );
      },
    );
  }
}
