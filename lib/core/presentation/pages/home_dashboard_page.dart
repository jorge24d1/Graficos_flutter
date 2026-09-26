import 'package:flutter/material.dart';
import '../../../features/material_charts/presentation/pages/material_charts_showcase_page.dart';
import '../../../features/flutter_echarts/presentation/pages/flutter_echarts_showcase_page.dart';
import '../../../features/high_chart/presentation/pages/high_chart_showcase_page.dart';
import '../../../features/syncfusion_flutter_charts/presentation/pages/syncfusion_flutter_charts_showcase_page.dart';

class ChartLibraryOption {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Widget targetPage;
  final bool isCompleted;

  const ChartLibraryOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.targetPage,
    this.isCompleted = false,
  });
}

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  static final List<ChartLibraryOption> _libraries = [
    const ChartLibraryOption(
      title: 'Material Charts',
      description: 'Librería nativa de Flutter con estilo Material Design 3.',
      icon: Icons.bar_chart_rounded,
      color: Color(0xFF6750A4),
      targetPage: MaterialChartsShowcasePage(),
      isCompleted: true,
    ),
    const ChartLibraryOption(
      title: 'Flutter Echarts',
      description: 'Wrapper de Apache ECharts renderizado vía WebView.',
      icon: Icons.pie_chart_outline_rounded,
      color: Color(0xFF006874),
      targetPage: FlutterEchartsShowcasePage(),
      isCompleted: false,
    ),
    const ChartLibraryOption(
      title: 'High Charts',
      description: 'Librería JS de Highcharts integrada con WebView en Flutter.',
      icon: Icons.show_chart_rounded,
      color: Color(0xFF984061),
      targetPage: HighChartShowcasePage(),
      isCompleted: true,
    ),
    const ChartLibraryOption(
      title: 'Syncfusion Charts',
      description: 'Componentes nativos de Syncfusion: ricos y personalizables.',
      icon: Icons.candlestick_chart_rounded,
      color: Color(0xFF705D00),
      targetPage: SyncfusionFlutterChartsShowcasePage(),
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.dashboard_rounded, size: 28),
            SizedBox(width: 12),
            Text(
              'Proyecto de Gráficos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona una Librería de Gráficos',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Elige el apartado de visualizaciones que deseas explorar:',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 1;
                    if (constraints.maxWidth > 900) {
                      crossAxisCount = 2;
                    }

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisExtent: 160,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _libraries.length,
                      itemBuilder: (context, index) {
                        final lib = _libraries[index];

                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: lib.color.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => lib.targetPage,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: lib.color.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      lib.icon,
                                      size: 32,
                                      color: lib.color,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                lib.title,
                                                style: theme.textTheme.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (lib.isCompleted)
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.green.withValues(alpha: 0.15),
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.green,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Completado',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          lib.description,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              'Ver gráficos',
                                              style: TextStyle(
                                                color: lib.color,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 16,
                                              color: lib.color,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
