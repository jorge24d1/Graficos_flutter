import '../../domain/entities/chart_dataset.dart';
import '../../domain/repositories/chart_repository.dart';
import '../datasources/chart_mock_datasource.dart';

class ChartRepositoryImpl implements ChartRepository {
  final ChartMockDatasource datasource;
  ChartRepositoryImpl(this.datasource);

  @override
  Future<ChartDataset> getChartData() async {
    final models = datasource.getMockData();
    return ChartDataset(title: 'Mock Data', points: models);
  }
}
