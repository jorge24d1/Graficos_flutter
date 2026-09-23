import '../models/chart_data_model.dart';

class ChartMockDatasource {
  List<ChartDataModel> getMockData() {
    return [
      ChartDataModel(label: 'Jan', value: 10),
      ChartDataModel(label: 'Feb', value: 25),
      ChartDataModel(label: 'Mar', value: 18),
    ];
  }
}
