import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsBasicBubbleChartWidget extends StatelessWidget {
  const FlutterEchartsBasicBubbleChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          xAxis: {
            splitLine: {
              lineStyle: {
                type: 'dashed'
              }
            }
          },
          yAxis: {
            splitLine: {
              lineStyle: {
                type: 'dashed'
              }
            },
            scale: true
          },
          series: [{
            name: '1990',
            data: [
              [28604, 77, 17096869, 'Australia', 1990],
              [31163, 77.4, 27662440, 'Canada', 1990],
              [1516, 68, 1154605773, 'China', 1990],
              [13670, 74.7, 10582082, 'Cuba', 1990]
            ],
            type: 'scatter',
            symbolSize: function (data) {
              return Math.sqrt(data[2]) / 500;
            },
            emphasis: {
              focus: 'series',
              label: {
                show: true,
                formatter: function (param) {
                  return param.data[3];
                },
                position: 'top'
              }
            },
            itemStyle: {
              shadowBlur: 10,
              shadowColor: 'rgba(120, 36, 50, 0.5)',
              shadowOffsetY: 5,
              color: 'rgba(120, 36, 50, 0.5)'
            }
          }]
        }
        ''',
      ),
    );
  }
}
