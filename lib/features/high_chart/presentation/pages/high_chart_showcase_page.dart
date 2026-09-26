import 'package:flutter/material.dart';

// Básicos
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

// Avanzados
import '../advanced_charts/advanced_candlestick_chart_widget.dart';
import '../advanced_charts/advanced_heatmap_chart_widget.dart';
import '../advanced_charts/advanced_treemap_chart_widget.dart';
import '../advanced_charts/advanced_funnel_chart_widget.dart';
import '../advanced_charts/advanced_waterfall_chart_widget.dart';
import '../advanced_charts/advanced_sankey_chart_widget.dart';
import '../advanced_charts/advanced_combined_multi_axis_chart_widget.dart';
import '../advanced_charts/advanced_realtime_stream_chart_widget.dart';

class _ChartItem {
  final String title;
  final String description;
  final Widget widget;

  const _ChartItem({
    required this.title,
    required this.description,
    required this.widget,
  });
}

class HighChartShowcasePage extends StatefulWidget {
  const HighChartShowcasePage({super.key});

  @override
  State<HighChartShowcasePage> createState() => _HighChartShowcasePageState();
}

class _HighChartShowcasePageState extends State<HighChartShowcasePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const List<_ChartItem> _basicCharts = [
    _ChartItem(title: 'Barras', description: 'Ventas por ciudad', widget: HighChartBasicBarChartWidget()),
    _ChartItem(title: 'Líneas', description: 'Evolución temporal', widget: HighChartBasicLineChartWidget()),
    _ChartItem(title: 'Pastel', description: 'Distribución por categoría', widget: HighChartBasicPieChartWidget()),
    _ChartItem(title: 'Dona', description: 'Ventas por categoría', widget: HighChartBasicDonutChartWidget()),
    _ChartItem(title: 'Área', description: 'Temperatura diaria', widget: HighChartBasicAreaChartWidget()),
    _ChartItem(title: 'Dispersión', description: 'Edad vs salario', widget: HighChartBasicScatterChartWidget()),
    _ChartItem(title: 'Burbuja', description: 'Comparativa multidimensional', widget: HighChartBasicBubbleChartWidget()),
    _ChartItem(title: 'Radar', description: 'Perfil de rendimiento', widget: HighChartBasicRadarChartWidget()),
    _ChartItem(title: 'Velocímetro', description: 'Cumplimiento de meta', widget: HighChartBasicGaugeChartWidget()),
    _ChartItem(title: 'Spline', description: 'Curva suavizada de ventas', widget: HighChartBasicSplineChartWidget()),
    _ChartItem(title: 'Barras apiladas', description: 'Online vs tienda por depto.', widget: HighChartBasicStackedBarChartWidget()),
    _ChartItem(title: 'Línea escalonada', description: 'Ventas acumuladas por mes', widget: HighChartBasicSteppedLineChartWidget()),
  ];

  static const List<_ChartItem> _advancedCharts = [
    _ChartItem(title: 'Velas (Candlestick)', description: 'Precios históricos de acción', widget: HighChartAdvancedCandlestickChartWidget()),
    _ChartItem(title: 'Mapa de calor', description: 'Actividad por hora y día', widget: HighChartAdvancedHeatmapChartWidget()),
    _ChartItem(title: 'Treemap', description: 'Participación de categorías', widget: HighChartAdvancedTreemapChartWidget()),
    _ChartItem(title: 'Embudo', description: 'Conversión del proceso de ventas', widget: HighChartAdvancedFunnelChartWidget()),
    _ChartItem(title: 'Cascada', description: 'Variaciones acumuladas de ingresos', widget: HighChartAdvancedWaterfallChartWidget()),
    _ChartItem(title: 'Sankey', description: 'Flujo de clientes por canal', widget: HighChartAdvancedSankeyChartWidget()),
    _ChartItem(title: 'Multi-eje combinado', description: 'Lluvia y temperatura combinados', widget: HighChartAdvancedCombinedMultiAxisChartWidget()),
    _ChartItem(title: 'Tiempo real', description: 'Stream en vivo con datos de sensor', widget: HighChartAdvancedRealtimeStreamChartWidget()),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerHighest,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF0086D4).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.bar_chart_rounded, color: Color(0xFF0086D4), size: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Highcharts',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '12 básicos · 8 avanzados',
                  style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF0086D4),
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          indicatorColor: const Color(0xFF0086D4),
          indicatorWeight: 3,
          tabs: const [
            Tab(icon: Icon(Icons.show_chart), text: 'Básicos (12)'),
            Tab(icon: Icon(Icons.auto_graph), text: 'Avanzados (8)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ChartListView(charts: _basicCharts),
          _ChartListView(charts: _advancedCharts),
        ],
      ),
    );
  }
}

class _ChartListView extends StatelessWidget {
  final List<_ChartItem> charts;
  const _ChartListView({required this.charts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemCount: charts.length,
      itemBuilder: (context, index) => _ChartCard(item: charts[index]),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final _ChartItem item;
  const _ChartCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: const Color(0xFF0086D4).withValues(alpha: 0.2), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF0086D4).withValues(alpha: 0.08),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.bar_chart_rounded, size: 18, color: Color(0xFF0086D4)),
                const SizedBox(width: 8),
                Text(
                  item.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0086D4),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '· ${item.description}',
                    style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 320, child: item.widget),
        ],
      ),
    );
  }
}