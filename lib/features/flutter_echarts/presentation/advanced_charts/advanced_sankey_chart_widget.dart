import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsAdvancedSankeyChartWidget extends StatelessWidget {
  const FlutterEchartsAdvancedSankeyChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          tooltip: {
            trigger: 'item',
            triggerOn: 'mousemove'
          },
          series: {
            type: 'sankey',
            layout: 'none',
            emphasis: {
              focus: 'adjacency'
            },
            data: [
              { name: 'a' },
              { name: 'b' },
              { name: 'a1' },
              { name: 'a2' },
              { name: 'b1' },
              { name: 'c' }
            ],
            links: [
              { source: 'a', target: 'a1', value: 5 },
              { source: 'a', target: 'a2', value: 3 },
              { source: 'b', target: 'b1', value: 8 },
              { source: 'a', target: 'b1', value: 3 },
              { source: 'b1', target: 'a1', value: 1 },
              { source: 'b1', target: 'c', value: 2 }
            ]
          }
        }
        ''',
      ),
    );
  }
}
