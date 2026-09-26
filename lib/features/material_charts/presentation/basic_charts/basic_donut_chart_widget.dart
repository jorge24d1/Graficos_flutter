import 'package:flutter/material.dart';
import '../../data/models/material_chart_models.dart';
import 'basic_pie_chart_widget.dart';

class MaterialChartsBasicDonutChartWidget extends StatelessWidget {
  final List<BasicChartDataPoint>? data;
  const MaterialChartsBasicDonutChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return MaterialChartsBasicPieChartWidget(
      data: data,
      isDonut: true,
    );
  }
}