import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data/highchart_data_service.dart';
import '../widgets/highcharts_widget.dart';
import '../widgets/highchart_description_card.dart';

class HighChartAdvancedRealtimeStreamChartWidget extends StatefulWidget {
  final bool showDescription;

  const HighChartAdvancedRealtimeStreamChartWidget({
    super.key,
    this.showDescription = true,
  });

  @override
  State<HighChartAdvancedRealtimeStreamChartWidget> createState() =>
      _HighChartAdvancedRealtimeStreamChartWidgetState();
}

class _HighChartAdvancedRealtimeStreamChartWidgetState
    extends State<HighChartAdvancedRealtimeStreamChartWidget> {
  final _random = Random();
  Timer? _timer;
  HighchartsController? _chartController;
  double _lastValue = 22;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStreaming() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Simula una nueva lectura de "sensor" con una pequeña variación
      // aleatoria respecto a la anterior (random walk).
      _lastValue += (_random.nextDouble() - 0.5) * 2;
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      // true = shift (bota el punto más viejo para mantener la ventana
      // deslizante en 20 puntos visibles)
      _chartController?.runJs(
        'window.chart.series[0].addPoint([$timestamp, ${_lastValue.toStringAsFixed(2)}], true, true);',
      );
    });
  }

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

        // Semilla inicial: usamos "temperatura" para arrancar el chart
        // con datos reales antes de empezar a simular en vivo.
        final temperatura = snapshot.data!['temperatura'] as List<dynamic>;
        final now = DateTime.now();
        final seedData = <List<num>>[];
        for (var i = 0; i < temperatura.length; i++) {
          final secondsAgo = (temperatura.length - i) * 2;
          final timestamp =
              now.subtract(Duration(seconds: secondsAgo)).millisecondsSinceEpoch;
          seedData.add([timestamp, temperatura[i]['temperatura']]);
        }
        _lastValue = (temperatura.last['temperatura'] as int).toDouble();

        final options = {
          'chart': {'type': 'spline', 'backgroundColor': 'transparent'},
          'title': {'text': 'Sensor en Tiempo Real'},
          'xAxis': {'type': 'datetime', 'tickPixelInterval': 100},
          'yAxis': {
            'title': {'text': 'Valor'},
          },
          'series': [
            {
              'name': 'Lectura',
              'data': seedData,
              'color': '#2E86DE',
            },
          ],
          'legend': {'enabled': false},
          'credits': {'enabled': false},
        };

        final chartWidget = HighchartsWidget(
          options: options,
          onReady: (controller) {
            _chartController = controller;
            _startStreaming();
          },
        );

        if (!widget.showDescription) {
          return chartWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            chartWidget,
            const HighChartDescriptionCard(
              title: 'Gráfico de Transmisión en Tiempo Real (Live Stream)',
              description:
                  'Visualización continua de alta frecuencia que incorpora dinámicamente nuevas mediciones en vivo por segundo y descarta los registros antiguos mediante una ventana temporal deslizante.',
              useCases:
                  'Es indispensable en telemetría de dispositivos IoT, control de procesos industriales automatizados, signos vitales médicos, monitorización de infraestructura de servidores (CPU/memoria) y trading algorítmico.',
              interpretation:
                  'Permite supervisar la estabilidad operativa minuto a minuto, identificar anomalías, picos súbitos o desviaciones críticas en el instante preciso en que se generan, facilitando respuestas de contingencia inmediatas.',
              icon: Icons.sensors_rounded,
            ),
          ],
        );
      },
    );
  }
}
