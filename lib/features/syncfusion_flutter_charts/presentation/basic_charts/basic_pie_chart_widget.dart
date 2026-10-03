import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsBasicPieChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsBasicPieChartWidget({super.key});

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

        final dataList = snapshot.data!['ventas_ciudades'] as List<dynamic>;

        return SfCircularChart(
          title: ChartTitle(text: 'Ventas Ciudades (Pastel)'),
          legend: Legend(isVisible: true),
                series: <CircularSeries>[
        PieSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['ciudad'].toString(),
          yValueMapper: (dynamic item, _) => item['ventas'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          
        )
      ],
        );
      },
    );
  }
}
