import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class FlutterEchartsAdvancedRealtimeStreamChartWidget extends StatelessWidget {
  const FlutterEchartsAdvancedRealtimeStreamChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Echarts(
        option: '''
        {
          title: {
            text: 'Dynamic Data'
          },
          tooltip: {
            trigger: 'axis',
            axisPointer: {
              type: 'cross',
              label: {
                backgroundColor: '#283b56'
              }
            }
          },
          legend: {},
          dataZoom: {
            show: false,
            start: 0,
            end: 100
          },
          xAxis: [
            {
              type: 'category',
              boundaryGap: true,
              data: (function (){
                var now = new Date();
                var res = [];
                var len = 10;
                while (len--) {
                  res.unshift(now.toLocaleTimeString().replace(/^\\D*/,''));
                  now = new Date(now - 2000);
                }
                return res;
              })()
            }
          ],
          yAxis: [
            {
              type: 'value',
              scale: true,
              name: 'Price',
              max: 30,
              min: 0,
              boundaryGap: [0.2, 0.2]
            }
          ],
          series: [
            {
              name: 'Dynamic Bar',
              type: 'bar',
              data: (function (){
                var res = [];
                var len = 10;
                while (len--) {
                  res.push(Math.round(Math.random() * 1000) / 100);
                }
                return res;
              })()
            },
            {
              name: 'Dynamic Line',
              type: 'line',
              data: (function (){
                var res = [];
                var len = 0;
                while (len < 10) {
                  res.push((Math.random()*10 + 5).toFixed(1) - 0);
                  len++;
                }
                return res;
              })()
            }
          ]
        }
        ''',
      ),
    );
  }
}
