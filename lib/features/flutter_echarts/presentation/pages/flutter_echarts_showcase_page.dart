import 'package:flutter/material.dart';

import '../basic_charts/basic_area_chart_widget.dart';
import '../basic_charts/basic_bar_chart_widget.dart';
import '../basic_charts/basic_bubble_chart_widget.dart';
import '../basic_charts/basic_donut_chart_widget.dart';
import '../basic_charts/basic_gauge_chart_widget.dart';
import '../basic_charts/basic_line_chart_widget.dart';
import '../basic_charts/basic_pie_chart_widget.dart';
import '../basic_charts/basic_radar_chart_widget.dart';
import '../basic_charts/basic_scatter_chart_widget.dart';
import '../basic_charts/basic_spline_chart_widget.dart';
import '../basic_charts/basic_stacked_bar_chart_widget.dart';
import '../basic_charts/basic_stepped_line_chart_widget.dart';

import '../advanced_charts/advanced_candlestick_chart_widget.dart';
import '../advanced_charts/advanced_combined_multi_axis_chart_widget.dart';
import '../advanced_charts/advanced_funnel_chart_widget.dart';
import '../advanced_charts/advanced_heatmap_chart_widget.dart';
import '../advanced_charts/advanced_realtime_stream_chart_widget.dart';
import '../advanced_charts/advanced_sankey_chart_widget.dart';
import '../advanced_charts/advanced_treemap_chart_widget.dart';
import '../advanced_charts/advanced_waterfall_chart_widget.dart';

class _ChartItem {
  final int number;
  final String title;
  final String description;
  final Widget chart;
  final bool isBasic;

  _ChartItem({
    required this.number,
    required this.title,
    required this.description,
    required this.chart,
    required this.isBasic,
  });
}

class FlutterEchartsShowcasePage extends StatefulWidget {
  const FlutterEchartsShowcasePage({super.key});

  @override
  State<FlutterEchartsShowcasePage> createState() => _FlutterEchartsShowcasePageState();
}

class _FlutterEchartsShowcasePageState extends State<FlutterEchartsShowcasePage> {
  String _searchQuery = '';

  late final List<_ChartItem> _allCharts;

  @override
  void initState() {
    super.initState();
    _allCharts = [
      _ChartItem(number: 1, title: 'Basic Bar Chart', description: 'Gráfico de barras para comparar categorías.', chart: FlutterEchartsBasicBarChartWidget(), isBasic: true),
      _ChartItem(number: 2, title: 'Basic Line Chart', description: 'Gráfico de líneas para mostrar tendencias en el tiempo.', chart: FlutterEchartsBasicLineChartWidget(), isBasic: true),
      _ChartItem(number: 3, title: 'Basic Pie Chart', description: 'Gráfico circular para mostrar proporciones.', chart: FlutterEchartsBasicPieChartWidget(), isBasic: true),
      _ChartItem(number: 4, title: 'Basic Donut Chart', description: 'Gráfico de dona similar al circular, con centro vacío.', chart: FlutterEchartsBasicDonutChartWidget(), isBasic: true),
      _ChartItem(number: 5, title: 'Basic Area Chart', description: 'Gráfico de área para mostrar el volumen bajo una línea.', chart: FlutterEchartsBasicAreaChartWidget(), isBasic: true),
      _ChartItem(number: 6, title: 'Basic Gauge Chart', description: 'Indicador visual para mostrar progreso o estado.', chart: FlutterEchartsBasicGaugeChartWidget(), isBasic: true),
      _ChartItem(number: 7, title: 'Basic Radar Chart', description: 'Gráfico de radar para comparar múltiples variables.', chart: FlutterEchartsBasicRadarChartWidget(), isBasic: true),
      _ChartItem(number: 8, title: 'Basic Scatter Chart', description: 'Gráfico de dispersión para mostrar relación entre dos variables.', chart: FlutterEchartsBasicScatterChartWidget(), isBasic: true),
      _ChartItem(number: 9, title: 'Basic Bubble Chart', description: 'Gráfico de burbujas para tres dimensiones de datos.', chart: FlutterEchartsBasicBubbleChartWidget(), isBasic: true),
      _ChartItem(number: 10, title: 'Basic Spline Chart', description: 'Gráfico de líneas suavizadas.', chart: FlutterEchartsBasicSplineChartWidget(), isBasic: true),
      _ChartItem(number: 11, title: 'Basic Stacked Bar Chart', description: 'Gráfico de barras apiladas para partes de un todo.', chart: FlutterEchartsBasicStackedBarChartWidget(), isBasic: true),
      _ChartItem(number: 12, title: 'Basic Stepped Line Chart', description: 'Gráfico de líneas escalonadas.', chart: FlutterEchartsBasicSteppedLineChartWidget(), isBasic: true),
      
      _ChartItem(number: 13, title: 'Advanced Candlestick Chart', description: 'Gráfico de velas para análisis financiero.', chart: FlutterEchartsAdvancedCandlestickChartWidget(), isBasic: false),
      _ChartItem(number: 14, title: 'Advanced Combined Multi Axis Chart', description: 'Gráfico combinado con múltiples ejes Y.', chart: FlutterEchartsAdvancedCombinedMultiAxisChartWidget(), isBasic: false),
      _ChartItem(number: 15, title: 'Advanced Funnel Chart', description: 'Gráfico de embudo para mostrar etapas de un proceso.', chart: FlutterEchartsAdvancedFunnelChartWidget(), isBasic: false),
      _ChartItem(number: 16, title: 'Advanced Heatmap Chart', description: 'Mapa de calor para representar densidad de datos en matriz.', chart: FlutterEchartsAdvancedHeatmapChartWidget(), isBasic: false),
      _ChartItem(number: 17, title: 'Advanced Realtime Stream Chart', description: 'Gráfico en tiempo real para flujos continuos de datos.', chart: FlutterEchartsAdvancedRealtimeStreamChartWidget(), isBasic: false),
      _ChartItem(number: 18, title: 'Advanced Sankey Chart', description: 'Gráfico de Sankey para mostrar flujos y transferencias.', chart: FlutterEchartsAdvancedSankeyChartWidget(), isBasic: false),
      _ChartItem(number: 19, title: 'Advanced Treemap Chart', description: 'Mapa de árbol para datos jerárquicos anidados.', chart: FlutterEchartsAdvancedTreemapChartWidget(), isBasic: false),
      _ChartItem(number: 20, title: 'Advanced Waterfall Chart', description: 'Gráfico de cascada para mostrar efectos acumulativos.', chart: FlutterEchartsAdvancedWaterfallChartWidget(), isBasic: false),
    ];
  }

  Widget _buildChartCard(BuildContext context, _ChartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${item.number} ${item.title}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 16),
            item.chart,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredBasic = _allCharts
        .where((c) => c.isBasic && c.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    final filteredAdvanced = _allCharts
        .where((c) => !c.isBasic && c.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Echarts Showcase'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Básicos'),
              Tab(text: 'Avanzados'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar gráfico',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredBasic.length,
                    itemBuilder: (context, index) {
                      return _buildChartCard(context, filteredBasic[index]);
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredAdvanced.length,
                    itemBuilder: (context, index) {
                      return _buildChartCard(context, filteredAdvanced[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
