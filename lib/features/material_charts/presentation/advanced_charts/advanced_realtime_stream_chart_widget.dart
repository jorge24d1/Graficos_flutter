import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedRealtimeStreamChartWidget extends StatefulWidget {
  const MaterialChartsAdvancedRealtimeStreamChartWidget({super.key});

  @override
  State<MaterialChartsAdvancedRealtimeStreamChartWidget> createState() =>
      _MaterialChartsAdvancedRealtimeStreamChartWidgetState();
}

class _MaterialChartsAdvancedRealtimeStreamChartWidgetState
    extends State<MaterialChartsAdvancedRealtimeStreamChartWidget> {
  final List<BasicChartDataPoint> _streamPoints = [];
  Timer? _timer;
  final math.Random _random = math.Random();
  int _counter = 0;
  bool _isStreaming = true;

  @override
  void initState() {
    super.initState();
    // Initialize with 10 initial points
    for (int i = 0; i < 12; i++) {
      _addPoint();
    }
    _startStream();
  }

  void _addPoint() {
    _counter++;
    final double prevVal =
        _streamPoints.isEmpty ? 50.0 : _streamPoints.last.value;
    final double delta = (_random.nextDouble() - 0.48) * 12.0;
    final double newVal = (prevVal + delta).clamp(10.0, 100.0);

    _streamPoints.add(
      BasicChartDataPoint(
        label: '${_counter}s',
        value: newVal,
      ),
    );

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
    final theme = Theme.of(context);
    final currentVal = _streamPoints.isEmpty ? 0.0 : _streamPoints.last.value;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gráfico en Tiempo Real (Realtime Stream)',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Valor actual: ${currentVal.toStringAsFixed(2)}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  _isStreaming ? Icons.pause_circle : Icons.play_circle,
                  color: theme.colorScheme.primary,
                  size: 28,
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
            child: CustomPaint(
              painter: _StreamPainter(
                points: _streamPoints,
                lineColor: theme.colorScheme.primary,
                gridColor: theme.colorScheme.outlineVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreamPainter extends CustomPainter {
  final List<BasicChartDataPoint> points;
  final Color lineColor;
  final Color gridColor;

  _StreamPainter({
    required this.points,
    required this.lineColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 3; i++) {
      final y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final stepX = size.width / (points.length - 1);
    final List<Offset> offsets = [];

    for (int i = 0; i < points.length; i++) {
      final x = i * stepX;
      final y = size.height - (points[i].value / 100.0) * (size.height - 20);
      offsets.add(Offset(x, y));
    }

    final path = Path()..moveTo(offsets[0].dx, offsets[0].dy);
    for (int i = 1; i < offsets.length; i++) {
      path.lineTo(offsets[i].dx, offsets[i].dy);
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = Colors.green;
    canvas.drawCircle(offsets.last, 6.0, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _StreamPainter oldDelegate) => true;
}
