import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';

class HighChartBasicGaugeChartWidget extends StatelessWidget {
  const HighChartBasicGaugeChartWidget({super.key});

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

        final cumplimiento =
            snapshot.data!['cumplimiento'] as Map<String, dynamic>;
        final actual = cumplimiento['actual'];
        final meta = cumplimiento['meta'];

        final options = {
          'chart': {
            'type': 'gauge',
            'backgroundColor': 'transparent',
          },
          'title': {'text': 'Cumplimiento de Meta'},
          'pane': {
            'startAngle': -90,
            'endAngle': 89.9,
            'background': null,
            'center': ['50%', '75%'],
            'size': '110%',
          },
          'yAxis': {
            'min': 0,
            'max': 100,
            'tickPixelInterval': 40,
            'plotBands': [
              {'from': 0, 'to': 50, 'color': '#EE5253'},
              {'from': 50, 'to': 80, 'color': '#F5B041'},
              {'from': 80, 'to': 100, 'color': '#2ECC71'},
            ],
            // Línea marcando dónde está la meta
            'plotLines': [
              {
                'value': meta,
                'color': '#2E86DE',
                'width': 3,
                'zIndex': 5,
              },
            ],
          },
          'series': [
            {
              'name': 'Cumplimiento',
              'data': [actual],
              'dataLabels': {
                'format': '{y}%',
              },
            },
          ],
          'credits': {'enabled': false},
        };

        return HighchartsWidget(options: options, height: 320);
      },
    );
  }
}