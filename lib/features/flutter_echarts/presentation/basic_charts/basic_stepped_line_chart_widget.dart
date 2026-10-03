import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsBasicSteppedLineChartWidget extends StatelessWidget {
  const FlutterEchartsBasicSteppedLineChartWidget({super.key});

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
            name: 'Step Start',
            type: 'line',
            step: 'start',
            data: [120, 132, 101, 134, 90, 230, 210]
          }]
        }
        ''',
      ),
    );
  }
}
