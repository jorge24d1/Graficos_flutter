import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsBasicDonutChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsBasicDonutChartWidget({super.key});

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

        final dataList = snapshot.data!['ventas_categorias'] as List<dynamic>;

        return SfCircularChart(
          title: ChartTitle(text: 'Ventas Categorías (Dona)'),
          legend: Legend(isVisible: true),
                series: <CircularSeries>[
        DoughnutSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['categoria'].toString(),
          yValueMapper: (dynamic item, _) => item['ventas'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          
        )
      ],
        );
      },
    );
  }
}
