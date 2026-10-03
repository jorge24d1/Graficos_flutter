import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicStackedBarChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicStackedBarChartWidget({
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

        final ventasDepartamentos =
            snapshot.data!['ventas_departamentos'] as List<dynamic>;

        final departamentos = ventasDepartamentos
            .map((e) => e['departamento'] as String)
            .toList();
        final online =
            ventasDepartamentos.map((e) => e['online'] as int).toList();
        final tienda =
            ventasDepartamentos.map((e) => e['tienda'] as int).toList();

        final options = {
          'chart': {'type': 'bar', 'backgroundColor': 'transparent'},
          'title': {'text': 'Ventas por Departamento: Online vs Tienda'},
          'xAxis': {
            'categories': departamentos,
          },
          'yAxis': {
            'min': 0,
            'title': {'text': 'Unidades vendidas'},
          },
          'plotOptions': {
            'series': {
              'stacking': 'normal',
            },
          },
          'series': [
            {'name': 'Online', 'data': online, 'color': '#2E86DE'},
            {'name': 'Tienda', 'data': tienda, 'color': '#F5B041'},
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
              title: 'Gráfico de Barras Apiladas (Stacked Bar)',
              description:
                  'Divide cada barra horizontal en sub-segmentos proporcionales apilados, permitiendo visualizar tanto el total agregado de cada categoría como la composición interna de sus partes.',
              useCases:
                  'Es muy útil para analizar la participación de canales comerciales complementarios (como unidades vendidas en canal online versus tienda física) cruzados por departamento o línea de negocio.',
              interpretation:
                  'Permite evaluar simultáneamente el volumen total alcanzado por cada departamento (longitud completa de la barra) y determinar qué canal ejerce mayor peso o predominio en cada área, detectando oportunidades de digitalización.',
              icon: Icons.view_column_rounded,
            ),
          ],
        );
      },
    );
  }
}
