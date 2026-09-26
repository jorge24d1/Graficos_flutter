import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsAdvancedHeatmapChartWidget extends StatelessWidget {
  const FlutterEchartsAdvancedHeatmapChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          tooltip: {
            position: 'top'
          },
          grid: {
            height: '50%',
            top: '10%'
          },
          xAxis: {
            type: 'category',
            data: ['12a', '1a', '2a', '3a', '4a', '5a', '6a', '7a'],
            splitArea: {
              show: true
            }
          },
          yAxis: {
            type: 'category',
            data: ['Saturday', 'Friday', 'Thursday', 'Wednesday'],
            splitArea: {
              show: true
            }
          },
          visualMap: {
            min: 0,
            max: 10,
            calculable: true,
            orient: 'horizontal',
            left: 'center',
            bottom: '15%'
          },
          series: [{
            name: 'Punch Card',
            type: 'heatmap',
            data: [
              [0,0,5],[0,1,1],[0,2,0],[0,3,0],[0,4,0],[0,5,0],[0,6,0],[0,7,0],
              [1,0,3],[1,1,0],[1,2,0],[1,3,0],[1,4,0],[1,5,0],[1,6,0],[1,7,0],
              [2,0,1],[2,1,1],[2,2,0],[2,3,0],[2,4,0],[2,5,0],[2,6,0],[2,7,0],
              [3,0,1],[3,1,3],[3,2,0],[3,3,0],[3,4,0],[3,5,1],[3,6,0],[3,7,0]
            ],
            label: {
              show: true
            },
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }]
        }
        ''',
      ),
    );
  }
}
