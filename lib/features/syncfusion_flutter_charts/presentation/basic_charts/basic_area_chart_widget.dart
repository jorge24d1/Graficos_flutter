import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsBasicAreaChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsBasicAreaChartWidget({super.key});

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

        final dataList = snapshot.data!['ventas_mensuales'] as List<dynamic>;

        return SfCartesianChart(
          title: ChartTitle(text: 'Ventas Mensuales (Área)'),
          legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(),
      series: <CartesianSeries>[
        AreaSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['mes'].toString(),
          yValueMapper: (dynamic item, _) => item['ventas'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          
        )
      ],
        );
      },
    );
  }
}
