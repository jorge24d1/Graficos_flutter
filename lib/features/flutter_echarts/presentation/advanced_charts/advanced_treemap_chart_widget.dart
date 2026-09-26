import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsAdvancedTreemapChartWidget extends StatelessWidget {
  const FlutterEchartsAdvancedTreemapChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          series: [{
            type: 'treemap',
            data: [{
              name: 'nodeA',
              value: 10,
              children: [{
                name: 'nodeAa',
                value: 4
              }, {
                name: 'nodeAb',
                value: 6
              }]
            }, {
              name: 'nodeB',
              value: 20,
              children: [{
                name: 'nodeBa',
                value: 20,
                children: [{
                  name: 'nodeBa1',
                  value: 20
                }]
              }]
            }]
          }]
        }
        ''',
      ),
    );
  }
}
