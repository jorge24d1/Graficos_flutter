import '../entities/chart_dataset.dart';

abstract class ChartRepository {
  Future<ChartDataset> getChartData();
}
