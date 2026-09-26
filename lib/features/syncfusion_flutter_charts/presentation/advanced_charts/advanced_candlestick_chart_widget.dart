import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsAdvancedCandlestickChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsAdvancedCandlestickChartWidget({super.key});

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

        final dataList = snapshot.data!['precios_accion'] as List<dynamic>;

        return SfCartesianChart(
          title: ChartTitle(text: 'Acciones (Velas)'),
          legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(),
      series: <CartesianSeries>[
        CandleSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['fecha'].toString(),
          lowValueMapper: (dynamic item, _) => item['minimo'],
          highValueMapper: (dynamic item, _) => item['maximo'],
          openValueMapper: (dynamic item, _) => item['apertura'],
          closeValueMapper: (dynamic item, _) => item['cierre'],
        )
      ],
        );
      },
    );
  }
}
