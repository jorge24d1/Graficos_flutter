import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartBasicScatterChartWidget extends StatelessWidget {
  final bool showDescription;

  const HighChartBasicScatterChartWidget({
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

        final edadSalario = snapshot.data!['edad_salario'] as List<dynamic>;

        final data = edadSalario.map((e) {
          return [e['edad'], e['salario']];
        }).toList();

        final options = {
          'chart': {'type': 'scatter', 'backgroundColor': 'transparent'},
          'title': {'text': 'Edad vs Salario'},
          'xAxis': {
            'title': {'text': 'Edad'},
          },
          'yAxis': {
            'title': {'text': 'Salario (COP)'},
          },
          'series': [
            {
              'name': 'Empleados',
              'data': data,
              'color': '#2E86DE',
              'marker': {'radius': 5},
            },
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
              title: 'Gráfico de Dispersión (Scatter Plot)',
              description:
                  'Grafica observaciones individuales como puntos cartesianos en dos ejes (X, Y) con el propósito de revelar patrones de distribución, densidad y el tipo de relación entre dos variables numéricas.',
              useCases:
                  'Es indispensable en analítica estadística, econometría y recursos humanos para evaluar hipótesis y correlaciones (como la relación entre la edad o años de experiencia y la compensación salarial de los colaboradores).',
              interpretation:
                  'Permite determinar si existe una correlación positiva (a mayor edad, mayor salario) o negativa, evaluar el grado de dispersión interna y descubrir valores atípicos (outliers) que se distancian del comportamiento promedio.',
              icon: Icons.grain_rounded,
            ),
          ],
        );
      },
    );
  }
}
