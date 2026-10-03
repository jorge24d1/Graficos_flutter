import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsAdvancedCandlestickChartWidget extends StatelessWidget {
  const FlutterEchartsAdvancedCandlestickChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          xAxis: {
            data: ['2017-10-24', '2017-10-25', '2017-10-26', '2017-10-27']
          },
          yAxis: {},
          series: [{
            type: 'candlestick',
            data: [
              [20, 34, 10, 38],
              [40, 35, 30, 50],
              [31, 38, 33, 44],
              [38, 15, 5, 42]
            ]
          }]
        }
        ''',
      ),
    );
  }
}
