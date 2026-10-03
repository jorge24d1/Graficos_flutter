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

class SfChartItemInfo {
  final String title;
  final String description;
  final Widget widget;
  final bool isAdvanced;

  const SfChartItemInfo({
    required this.title,
    required this.description,
    required this.widget,
    this.isAdvanced = false,
  });
}

class SyncfusionFlutterChartsShowcasePage extends StatefulWidget {
  const SyncfusionFlutterChartsShowcasePage({super.key});

  @override
  State<SyncfusionFlutterChartsShowcasePage> createState() =>
      _SyncfusionFlutterChartsShowcasePageState();
}

class _SyncfusionFlutterChartsShowcasePageState
    extends State<SyncfusionFlutterChartsShowcasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<SfChartItemInfo> _basicCharts = const [
    SfChartItemInfo(
      title: 'Bar Chart',
      description: 'Gráfico de barras horizontales para comparar productos.',
      widget: SyncfusionFlutterChartsBasicBarChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Line Chart',
      description: 'Gráfico de líneas continuas con temperatura por hora.',
      widget: SyncfusionFlutterChartsBasicLineChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Pie Chart',
      description: 'Gráfico circular para distribución de ventas por ciudad.',
      widget: SyncfusionFlutterChartsBasicPieChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Donut Chart',
      description: 'Gráfico en forma de dona por categoría de ventas.',
      widget: SyncfusionFlutterChartsBasicDonutChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Area Chart',
      description: 'Área acumulada con ventas mensuales y gradiente.',
      widget: SyncfusionFlutterChartsBasicAreaChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Scatter Plot',
      description: 'Dispersión de edad vs salario de empleados.',
      widget: SyncfusionFlutterChartsBasicScatterChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Bubble Chart',
      description: 'Burbujas de rendimiento: ventas y satisfacción.',
      widget: SyncfusionFlutterChartsBasicBubbleChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Radar Chart',
      description: 'Gráfico radial de ventas por vendedor.',
      widget: SyncfusionFlutterChartsBasicRadarChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Gauge Chart',
      description: 'Calibre radial de cumplimiento mensual.',
      widget: SyncfusionFlutterChartsBasicGaugeChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Spline Chart',
      description: 'Curva suave de temperatura con Bézier.',
      widget: SyncfusionFlutterChartsBasicSplineChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Stacked Bar Chart',
      description: 'Barras apiladas: ventas online vs tienda por depto.',
      widget: SyncfusionFlutterChartsBasicStackedBarChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Stepped Line Chart',
      description: 'Línea en escalones del progreso de ventas mensuales.',
      widget: SyncfusionFlutterChartsBasicSteppedLineChartWidget(),
    ),
  ];

  final List<SfChartItemInfo> _advancedCharts = const [
    SfChartItemInfo(
      title: 'Candlestick Chart',
      description: 'Velas financieras OHLC con datos históricos de acciones.',
      widget: SyncfusionFlutterChartsAdvancedCandlestickChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Heatmap Chart',
      description: 'Actividad por día de la semana y hora del día.',
      widget: SyncfusionFlutterChartsAdvancedHeatmapChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Treemap Chart',
      description: 'Distribución jerárquica por volumen de categorías.',
      widget: SyncfusionFlutterChartsAdvancedTreemapChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Funnel Chart',
      description: 'Embudo de conversión de visitantes a ventas.',
      widget: SyncfusionFlutterChartsAdvancedFunnelChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Waterfall Chart',
      description: 'Flujo acumulado de ventas mensuales en cascada.',
      widget: SyncfusionFlutterChartsAdvancedWaterfallChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Sankey Flow Chart',
      description: 'Flujo de clientes entre canales de conversión.',
      widget: SyncfusionFlutterChartsAdvancedSankeyChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Multi-Axis Combined Chart',
      description: 'Ventas (columnas) y clientes (línea) con doble eje Y.',
      widget: SyncfusionFlutterChartsAdvancedCombinedMultiAxisChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Realtime Stream Chart',
      description: 'Gráfico en tiempo real con datos de temperatura.',
      widget: SyncfusionFlutterChartsAdvancedRealtimeStreamChartWidget(),
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

  void _openDetailDialog(SfChartItemInfo item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: Text(item.title),
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
              'Syncfusion Charts Showcase',
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

  Widget _buildChartGrid(List<SfChartItemInfo> items) {
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
