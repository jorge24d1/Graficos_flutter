import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsAdvancedSankeyChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsAdvancedSankeyChartWidget({super.key});

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

        final dataList = snapshot.data!['flujo_clientes'] as List<dynamic>;

        return SfPyramidChart(
          title: ChartTitle(text: 'Flujo Clientes (Sustituto Pirámide)'),
          legend: Legend(isVisible: true),
                series: PyramidSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['origen'].toString(),
          yValueMapper: (dynamic item, _) => item['cantidad'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
        );
      },
    );
  }
}
