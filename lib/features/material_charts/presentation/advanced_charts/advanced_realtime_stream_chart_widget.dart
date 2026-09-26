import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';

class MaterialChartsAdvancedRealtimeStreamChartWidget extends StatefulWidget {
  const MaterialChartsAdvancedRealtimeStreamChartWidget({super.key});

  @override
  State<MaterialChartsAdvancedRealtimeStreamChartWidget> createState() =>
      _MaterialChartsAdvancedRealtimeStreamChartWidgetState();
}

class _MaterialChartsAdvancedRealtimeStreamChartWidgetState
    extends State<MaterialChartsAdvancedRealtimeStreamChartWidget> {
  final List<ChartData> _streamPoints = [];
  Timer? _timer;
  final math.Random _random = math.Random();
  int _counter = 0;
  bool _isStreaming = true;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      _addPoint();
    }
    _startStream();
  }

  void _addPoint() {
    _counter++;
    final double prevVal = _streamPoints.isEmpty ? 50.0 : _streamPoints.last.value;
    final double delta = (_random.nextDouble() - 0.48) * 12.0;
    final double newVal = (prevVal + delta).clamp(10.0, 100.0);

    _streamPoints.add(ChartData(label: '${_counter}s', value: newVal));

    if (_streamPoints.length > 20) {
      _streamPoints.removeAt(0);
    }
  }

  void _startStream() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      if (_isStreaming && mounted) {
        setState(() {
          _addPoint();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gráfico en Tiempo Real (MaterialChartLine)',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              IconButton(
                icon: Icon(
                  _isStreaming ? Icons.pause_circle : Icons.play_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    _isStreaming = !_isStreaming;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: MaterialChartLine(
              data: _streamPoints.toList(),
              width: 800,
              height: 400,
              style: const LineChartStyle(animationDuration: Duration(milliseconds: 0)),
            ),
          ),
        ],
      ),
    );
  }
}