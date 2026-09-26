import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsBasicSplineChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsBasicSplineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: SyncfusionDataService.loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final dataList = snapshot.data!['temperatura'] as List<dynamic>;

        return SfCartesianChart(
          title: ChartTitle(text: 'Temperatura Suavizada (Spline)'),
          legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(),
      series: <CartesianSeries>[
        SplineSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['hora'].toString(),
          yValueMapper: (dynamic item, _) => item['temperatura'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          
        )
      ],
        );
      },
    );
  }
}
