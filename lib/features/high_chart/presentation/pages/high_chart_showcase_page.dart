import 'package:flutter/material.dart';

// Básicos (12)
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

// Avanzados (8)
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

  late final TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final query = _searchQuery.toLowerCase();
    final filteredBasic = _basicCharts
        .where((c) =>
            c.title.toLowerCase().contains(query) ||
            c.description.toLowerCase().contains(query))
        .toList();
    final filteredAdvanced = _advancedCharts
        .where((c) =>
            c.title.toLowerCase().contains(query) ||
            c.description.toLowerCase().contains(query))
        .toList();

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
                  '${_basicCharts.length} básicos · ${_advancedCharts.length} avanzados (20 total)',
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
          tabs: [
            Tab(
              icon: const Icon(Icons.show_chart),
              text: 'Básicos (${filteredBasic.length})',
            ),
            Tab(
              icon: const Icon(Icons.auto_graph),
              text: 'Avanzados (${filteredAdvanced.length})',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Barra de búsqueda por nombre
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar gráfico por nombre...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF0086D4)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        tooltip: 'Limpiar búsqueda',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: const Color(0xFF0086D4).withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF0086D4),
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim();
                });
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ChartListView(charts: filteredBasic, searchQuery: _searchQuery),
                _ChartListView(charts: filteredAdvanced, searchQuery: _searchQuery),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartListView extends StatelessWidget {
  final List<_ChartItem> charts;
  final String searchQuery;

  const _ChartListView({
    required this.charts,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    if (charts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 56,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 14),
              Text(
                'No se encontraron gráficos',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                searchQuery.isNotEmpty
                    ? 'No hay resultados que coincidan con "$searchQuery".'
                    : 'No hay gráficos disponibles en esta sección.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      );
    }

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
          item.widget,
        ],
      ),
    );
  }
}