import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicAreaChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicAreaChartWidget({
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
              title: 'Gráfico de Área Comparativo',
              description:
                  'Amplía el gráfico de líneas rellenando con color el área inferior comprendida entre el eje horizontal y las curvas, enfatizando la magnitud acumulada y el volumen global a lo largo del tiempo.',
              useCases:
                  'Es muy útil para monitorear volúmenes agregados, facturación periódica y contrastar simultáneamente series de rendimiento real frente a umbrales objetivo o metas presupuestarias.',
              interpretation:
                  'Permite dimensionar visualmente la masa o volumen alcanzado en cada período, reconociendo al instante las brechas de déficit (donde las ventas están bajo la meta) o de superávit acumulado.',
              icon: Icons.area_chart_rounded,
            ),
          ],
        );
      },
    );
  }
}