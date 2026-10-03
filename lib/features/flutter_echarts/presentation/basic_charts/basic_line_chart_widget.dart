import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsBasicLineChartWidget extends StatelessWidget {
  const FlutterEchartsBasicLineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          xAxis: {
            type: 'category',
            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
          },
          yAxis: {
            type: 'value'
          },
          series: [{
            data: [150, 230, 224, 218, 135, 147, 260],
            type: 'line'
          }]
        }
        ''',
      ),
    );
  }
}
