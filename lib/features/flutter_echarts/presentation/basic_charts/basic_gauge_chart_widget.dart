import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsBasicGaugeChartWidget extends StatelessWidget {
  const FlutterEchartsBasicGaugeChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          tooltip: {
            formatter: '{a} <br/>{b} : {c}%'
          },
          series: [{
            name: 'Pressure',
            type: 'gauge',
            progress: {
              show: true
            },
            detail: {
              valueAnimation: true,
              formatter: '{value}'
            },
            data: [{
              value: 50,
              name: 'SCORE'
            }]
          }]
        }
        ''',
      ),
    );
  }
}
