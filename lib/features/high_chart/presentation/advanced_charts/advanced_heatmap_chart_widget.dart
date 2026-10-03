import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedHeatmapChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartAdvancedHeatmapChartWidget({
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

        final horasActividad =
            snapshot.data!['horas_actividad'] as List<dynamic>;

        // Las horas son las claves del mapa, excluyendo "dia"
        const horas = ['08', '10', '12', '14', '16'];
        final dias = horasActividad.map((e) => e['dia'] as String).toList();

        // Heatmap espera puntos [xIndex, yIndex, valor]
        final data = <List<num>>[];
        for (var yIndex = 0; yIndex < horasActividad.length; yIndex++) {
          final Map<String, dynamic> fila =
              horasActividad[yIndex] as Map<String, dynamic>;
          for (var xIndex = 0; xIndex < horas.length; xIndex++) {
            final valor = fila[horas[xIndex]] as int;
            data.add([xIndex, yIndex, valor]);
          }
        }

        final options = {
          'chart': {'type': 'heatmap', 'backgroundColor': 'transparent'},
          'title': {'text': 'Actividad por Día y Hora'},
          'xAxis': {
            'categories': horas.map((h) => '$h:00').toList(),
          },
          'yAxis': {
            'categories': dias,
            'title': null,
            'reversed': true,
          },
          'colorAxis': {
            'min': 0,
            'minColor': '#FFFFFF',
            'maxColor': '#2E86DE',
          },
          'legend': {
            'align': 'right',
            'layout': 'vertical',
            'verticalAlign': 'top',
          },
          'series': [
            {
              'name': 'Actividad',
              'borderWidth': 1,
              'data': data,
              'dataLabels': {
                'enabled': true,
                'color': '#000000',
              },
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
              title: 'Mapa de Calor Matricial (Heatmap)',
              description:
                  'Distribuye registros numéricos en una cuadrícula bidimensional cruzando dos variables categóricas, donde la magnitud de cada intersección se codifica mediante un gradiente térmico de color.',
              useCases:
                  'Es perfecto para descubrir patrones de concurrencia y carga operativa: horarios pico de atención al cliente, consumo de servidores, densidad de compras por día/hora o accidentalidad vial.',
              interpretation:
                  'Permite detectar al instante núcleos de saturación y alta demanda (celdas con azules más oscuros) frente a valles de inactividad o baja utilización (celdas claras), facilitando la asignación eficiente de personal y recursos técnicos.',
              icon: Icons.grid_on_rounded,
            ),
          ],
        );
      },
    );
  }
}
