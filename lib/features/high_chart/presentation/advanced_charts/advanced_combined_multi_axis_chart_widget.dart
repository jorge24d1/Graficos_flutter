import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedCombinedMultiAxisChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartAdvancedCombinedMultiAxisChartWidget({
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
              title: 'Gráfico Combinado Multi-Eje',
              description:
                  'Integra múltiples tipos de visualización (columnas y líneas) en un mismo lienzo utilizando dos o más ejes verticales independientes, permitiendo correlacionar métricas con escalas o unidades de medida muy dispares.',
              useCases:
                  'Es excelente para cruzar variables financieras en millones de pesos (como ventas y metas presupuestarias en el eje primario) con variables de conteo o volumen operativo (como número de clientes en el eje secundario).',
              interpretation:
                  'Permite diagnosticar si los aumentos en la facturación obedecen a un incremento en el volumen de clientes o a un mayor ticket promedio, analizando paralelamente la eficacia en el cumplimiento de las metas comerciales.',
              icon: Icons.stacked_line_chart_rounded,
            ),
          ],
        );
      },
    );
  }
}