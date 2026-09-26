import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsAdvancedFunnelChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsAdvancedFunnelChartWidget({super.key});

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

        final dataList = snapshot.data!['conversion_ventas'] as List<dynamic>;

        return SfFunnelChart(
          title: ChartTitle(text: 'Conversión Ventas (Embudo)'),
          legend: Legend(isVisible: true),
                series: FunnelSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['etapa'].toString(),
          yValueMapper: (dynamic item, _) => item['cantidad'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
        );
      },
    );
  }
}
