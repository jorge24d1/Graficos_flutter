import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsBasicStackedBarChartWidget extends StatelessWidget {
  const FlutterEchartsBasicStackedBarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          tooltip: {
            trigger: 'axis',
            axisPointer: { type: 'shadow' }
          },
          legend: {
            data: ['Direct', 'Mail Ad', 'Affiliate Ad', 'Video Ad', 'Search Engine']
          },
          grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
          },
          xAxis: {
            type: 'value'
          },
          yAxis: {
            type: 'category',
            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
          },
          series: [
            {
              name: 'Direct',
              type: 'bar',
              stack: 'total',
              label: { show: true },
              emphasis: { focus: 'series' },
              data: [320, 302, 301, 334, 390, 330, 320]
            },
            {
              name: 'Mail Ad',
              type: 'bar',
              stack: 'total',
              label: { show: true },
              emphasis: { focus: 'series' },
              data: [120, 132, 101, 134, 90, 230, 210]
            },
            {
              name: 'Affiliate Ad',
              type: 'bar',
              stack: 'total',
              label: { show: true },
              emphasis: { focus: 'series' },
              data: [220, 182, 191, 234, 290, 330, 310]
            }
          ]
        }
        ''',
      ),
    );
  }
}
