import '../../domain/entities/chart_data_point.dart';

class ChartDataModel extends ChartDataPoint {
  ChartDataModel({required super.label, required super.value});

  factory ChartDataModel.fromJson(Map<String, dynamic> json) {
    return ChartDataModel(
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
    );
  }
}
