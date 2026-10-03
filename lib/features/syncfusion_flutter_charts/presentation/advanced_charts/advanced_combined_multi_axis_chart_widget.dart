import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/syncfusion_data_service.dart';

class SyncfusionFlutterChartsAdvancedCombinedMultiAxisChartWidget extends StatelessWidget {
  const SyncfusionFlutterChartsAdvancedCombinedMultiAxisChartWidget({super.key});

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
          title: ChartTitle(text: 'Ventas vs Clientes (Multi-Eje)'),
          legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(),
      axes: <ChartAxis>[
        NumericAxis(name: 'yAxis2', opposedPosition: true)
      ],
      series: <CartesianSeries>[
        ColumnSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['mes'].toString(),
          yValueMapper: (dynamic item, _) => item['ventas'],
          name: 'Ventas',
        ),
        LineSeries<dynamic, String>(
          dataSource: dataList,
          xValueMapper: (dynamic item, _) => item['mes'].toString(),
          yValueMapper: (dynamic item, _) => item['clientes'],
          name: 'Clientes',
          yAxisName: 'yAxis2',
        )
      ],
        );
      },
    );
  }
}
