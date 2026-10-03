import 'package:flutter/material.dart';

// Basic Charts
import '../basic_charts/basic_bar_chart_widget.dart';
import '../basic_charts/basic_line_chart_widget.dart';
import '../basic_charts/basic_pie_chart_widget.dart';
import '../basic_charts/basic_donut_chart_widget.dart';
import '../basic_charts/basic_area_chart_widget.dart';
import '../basic_charts/basic_scatter_chart_widget.dart';
import '../basic_charts/basic_bubble_chart_widget.dart';
import '../basic_charts/basic_radar_chart_widget.dart';
import '../basic_charts/basic_gauge_chart_widget.dart';
import '../basic_charts/basic_spline_chart_widget.dart';
import '../basic_charts/basic_stacked_bar_chart_widget.dart';
import '../basic_charts/basic_stepped_line_chart_widget.dart';

// Advanced Charts
import '../advanced_charts/advanced_candlestick_chart_widget.dart';
import '../advanced_charts/advanced_heatmap_chart_widget.dart';
import '../advanced_charts/advanced_treemap_chart_widget.dart';
import '../advanced_charts/advanced_funnel_chart_widget.dart';
import '../advanced_charts/advanced_waterfall_chart_widget.dart';
import '../advanced_charts/advanced_sankey_chart_widget.dart';
import '../advanced_charts/advanced_combined_multi_axis_chart_widget.dart';
import '../advanced_charts/advanced_realtime_stream_chart_widget.dart';

class ChartItemInfo {
  final int number;
  final String title;
  final String description;
  final Widget widget;
  final bool isAdvanced;

  const ChartItemInfo({
    required this.number,
    required this.title,
    required this.description,
    required this.widget,
    this.isAdvanced = false,
  });
}

class MaterialChartsShowcasePage extends StatefulWidget {
  const MaterialChartsShowcasePage({super.key});

  @override
  State<MaterialChartsShowcasePage> createState() =>
      _MaterialChartsShowcasePageState();
}

class _MaterialChartsShowcasePageState extends State<MaterialChartsShowcasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<ChartItemInfo> _basicCharts = const [
    ChartItemInfo(
      number: 1,
      title: 'Bar Chart',
      description: 'Gráfico de barras verticales interactivo con animación y tooltips.',
      widget: MaterialChartsBasicBarChartWidget(),
    ),
    ChartItemInfo(
      number: 2,
      title: 'Line Chart',
      description: 'Gráfico de líneas continuas con marcadores de puntos e interactividad.',
      widget: MaterialChartsBasicLineChartWidget(),
    ),
    ChartItemInfo(
      number: 3,
      title: 'Pie Chart',
      description: 'Gráfico circular para distribución proporcional de categorías.',
      widget: MaterialChartsBasicPieChartWidget(),
    ),
    ChartItemInfo(
      number: 4,
      title: 'Donut Chart',
      description: 'Gráfico en forma de dona con resumen central.',
      widget: MaterialChartsBasicDonutChartWidget(),
    ),
    ChartItemInfo(
      number: 5,
      title: 'Area Chart',
      description: 'Gráfico de área con degradado de color bajo la curva.',
      widget: MaterialChartsBasicAreaChartWidget(),
    ),
    ChartItemInfo(
      number: 6,
      title: 'Scatter Plot',
      description: 'Gráfico de dispersión para correlaciones de dos variables.',
      widget: MaterialChartsBasicScatterChartWidget(),
    ),
    ChartItemInfo(
      number: 7,
      title: 'Bubble Chart',
      description: 'Gráfico de burbujas (X, Y y Tamaño de burbuja).',
      widget: MaterialChartsBasicBubbleChartWidget(),
    ),
    ChartItemInfo(
      number: 8,
      title: 'Radar Chart',
      description: 'Gráfico radial para evaluar múltiples atributos o KPIs.',
      widget: MaterialChartsBasicRadarChartWidget(),
    ),
    ChartItemInfo(
      number: 9,
      title: 'Gauge Chart',
      description: 'Calibre tipo velocímetro para métricas de desempeño.',
      widget: MaterialChartsBasicGaugeChartWidget(),
    ),
    ChartItemInfo(
      number: 10,
      title: 'Spline Chart',
      description: 'Línea de curva suave mediante Bézier cúbicas.',
      widget: MaterialChartsBasicSplineChartWidget(),
    ),
    ChartItemInfo(
      number: 11,
      title: 'Stacked Bar Chart',
      description: 'Barras apiladas multiserie por categoría.',
      widget: MaterialChartsBasicStackedBarChartWidget(),
    ),
    ChartItemInfo(
      number: 12,
      title: 'Stepped Line Chart',
      description: 'Línea en escalones para cambios discretos por fases.',
      widget: MaterialChartsBasicSteppedLineChartWidget(),
    ),
  ];

  final List<ChartItemInfo> _advancedCharts = const [
    ChartItemInfo(
      number: 1,
      title: 'Candlestick Chart',
      description: 'Velas financieras OHLC para análisis de bolsa y cripto.',
      widget: MaterialChartsAdvancedCandlestickChartWidget(),
      isAdvanced: true,
    ),
    ChartItemInfo(
      number: 2,
      title: 'Heatmap Chart',
      description: 'Mapa de calor matricial por día y hora.',
      widget: MaterialChartsAdvancedHeatmapChartWidget(),
      isAdvanced: true,
    ),
    ChartItemInfo(
      number: 3,
      title: 'Treemap Chart',
      description: 'Mapa de árbol jerárquico por volumen de proporción.',
      widget: MaterialChartsAdvancedTreemapChartWidget(),
      isAdvanced: true,
    ),
    ChartItemInfo(
      number: 4,
      title: 'Funnel Chart',
      description: 'Embudo de conversión de fases de usuario.',
      widget: MaterialChartsAdvancedFunnelChartWidget(),
      isAdvanced: true,
    ),
    ChartItemInfo(
      number: 5,
      title: 'Waterfall Chart',
      description: 'Gráfico en cascada para flujo financiero de pérdidas/ganancias.',
      widget: MaterialChartsAdvancedWaterfallChartWidget(),
      isAdvanced: true,
    ),
    ChartItemInfo(
      number: 6,
      title: 'Sankey Flow Chart',
      description: 'Diagrama de Sankey para flujo y transferencia entre nodos.',
      widget: MaterialChartsAdvancedSankeyChartWidget(),
      isAdvanced: true,
    ),
    ChartItemInfo(
      number: 7,
      title: 'Multi-Axis Combined Chart',
      description: 'Gráfico combinado multi-eje (Barras + Línea).',
      widget: MaterialChartsAdvancedCombinedMultiAxisChartWidget(),
      isAdvanced: true,
    ),
    ChartItemInfo(
      number: 8,
      title: 'Realtime Stream Chart',
      description: 'Gráfico en vivo en tiempo real con transmisión activa de datos.',
      widget: MaterialChartsAdvancedRealtimeStreamChartWidget(),
      isAdvanced: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openDetailDialog(ChartItemInfo item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: Text('#${item.number} - ${item.title}'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: item.widget,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredBasic = _basicCharts
        .where((c) => c.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    final filteredAdvanced = _advancedCharts
        .where((c) => c.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_graph, size: 28),
            SizedBox(width: 12),
            Text(
              'Material Charts Showcase',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.bar_chart),
              text: 'Básicos (${_basicCharts.length})',
            ),
            Tab(
              icon: const Icon(Icons.insights),
              text: 'Avanzados (${_advancedCharts.length})',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar gráfico...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildChartGrid(filteredBasic),
                _buildChartGrid(filteredAdvanced),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartGrid(List<ChartItemInfo> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text('No se encontraron gráficos con la búsqueda.'),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1100) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 700) {
          crossAxisCount = 2;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: 360,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '#${item.number}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      item.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.fullscreen),
                      tooltip: 'Expandir',
                      onPressed: () => _openDetailDialog(item),
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      child: item.widget,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
