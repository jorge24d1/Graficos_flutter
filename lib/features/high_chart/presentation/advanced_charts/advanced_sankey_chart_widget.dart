import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedSankeyChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartAdvancedSankeyChartWidget({
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

        final chartWidget = HighchartsWidget(options: options, height: 360);

        if (!showDescription) {
          return chartWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            chartWidget,
            const HighChartDescriptionCard(
              title: 'Diagrama de Sankey (Flujo de Distribución)',
              description:
                  'Visualiza trayectorias, transferencias y correlaciones de flujo entre múltiples nodos o etapas dentro de un sistema, donde el grosor de cada banda conectora es proporcional a la cantidad transferida.',
              useCases:
                  'Es idóneo para mapear la ruta y experiencia de los clientes (Customer Journey), flujos de navegación web entre páginas, balances de energía o costos, distribución presupuestaria y cadenas logísticas.',
              interpretation:
                  'Permite descubrir con total transparencia las rutas predominantes por donde transita la mayor masa de usuarios, identificar destinos secundarios y detectar puntos de fuga o dispersión donde el volumen se pierde significativamente.',
              icon: Icons.alt_route_rounded,
            ),
          ],
        );
      },
    );
  }
}
