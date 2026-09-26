import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsAdvancedHeatmapChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsAdvancedHeatmapChartWidget({super.key});

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

        final dataList = snapshot.data!['horas_actividad'] as List<dynamic>;

        return SfCartesianChart(
          title: ChartTitle(text: 'Horas Actividad (Sustituto Columnas)'),
          legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(),
      series: <CartesianSeries>[
        ColumnSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['dia'].toString(),
          yValueMapper: (dynamic item, _) => item['10'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          
        )
      ],
        );
      },
    );
  }
}
