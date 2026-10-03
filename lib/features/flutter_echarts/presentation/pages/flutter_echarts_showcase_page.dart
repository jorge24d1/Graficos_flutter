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

class EchartsChartItemInfo {
  final int number;
  final String title;
  final String description;
  final Widget widget;
  final bool isAdvanced;

  const EchartsChartItemInfo({
    required this.number,
    required this.title,
    required this.description,
    required this.widget,
    this.isAdvanced = false,
  });
}

class FlutterEchartsShowcasePage extends StatefulWidget {
  const FlutterEchartsShowcasePage({super.key});

  @override
  State<FlutterEchartsShowcasePage> createState() => _FlutterEchartsShowcasePageState();
}

class _FlutterEchartsShowcasePageState extends State<FlutterEchartsShowcasePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<EchartsChartItemInfo> _basicCharts = [
    EchartsChartItemInfo(
      number: 1,
      title: 'Basic Bar Chart',
      description: 'Gráfico de barras estándar. Útil para comparar cantidades entre diferentes categorías.',
      widget: FlutterEchartsBasicBarChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 2,
      title: 'Basic Line Chart',
      description: 'Gráfico de líneas continuas. Ideal para mostrar tendencias a lo largo del tiempo.',
      widget: FlutterEchartsBasicLineChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 3,
      title: 'Basic Pie Chart',
      description: 'Gráfico circular estándar. Sirve para mostrar las proporciones porcentuales de un todo.',
      widget: FlutterEchartsBasicPieChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 4,
      title: 'Basic Donut Chart',
      description: 'Variante del gráfico circular con el centro hueco. Facilita la lectura de proporciones.',
      widget: FlutterEchartsBasicDonutChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 5,
      title: 'Basic Area Chart',
      description: 'Gráfico de línea con el área inferior rellena. Destaca la magnitud de los cambios en el tiempo.',
      widget: FlutterEchartsBasicAreaChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 6,
      title: 'Basic Gauge Chart',
      description: 'Gráfico de medidor tipo velocímetro. Perfecto para indicar progreso o rendimiento respecto a una meta.',
      widget: FlutterEchartsBasicGaugeChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 7,
      title: 'Basic Radar Chart',
      description: 'Gráfico radial o de araña. Utilizado para evaluar una serie de variables respecto a un punto central.',
      widget: FlutterEchartsBasicRadarChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 8,
      title: 'Basic Scatter Chart',
      description: 'Gráfico de dispersión. Útil para encontrar relaciones o patrones entre dos variables numéricas.',
      widget: FlutterEchartsBasicScatterChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 9,
      title: 'Basic Bubble Chart',
      description: 'Variante del gráfico de dispersión donde el tamaño del punto representa una tercera variable.',
      widget: FlutterEchartsBasicBubbleChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 10,
      title: 'Basic Spline Chart',
      description: 'Gráfico de líneas con curvas suaves (interpolación). Ideal para tendencias orgánicas y fluidas.',
      widget: FlutterEchartsBasicSplineChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 11,
      title: 'Basic Stacked Bar Chart',
      description: 'Gráfico de barras apiladas. Muestra cómo diferentes segmentos componen el total de una categoría.',
      widget: FlutterEchartsBasicStackedBarChartWidget(),
    ),
    EchartsChartItemInfo(
      number: 12,
      title: 'Basic Stepped Line Chart',
      description: 'Gráfico de líneas escalonado. Se usa cuando los cambios ocurren a intervalos irregulares.',
      widget: FlutterEchartsBasicSteppedLineChartWidget(),
    ),
  ];

  final List<EchartsChartItemInfo> _advancedCharts = [
    EchartsChartItemInfo(
      number: 1,
      title: 'Advanced Candlestick Chart',
      description: 'Gráfico de velas japonesas (OHLC). Fundamental para el análisis técnico de mercados financieros.',
      widget: FlutterEchartsAdvancedCandlestickChartWidget(),
      isAdvanced: true,
    ),
    EchartsChartItemInfo(
      number: 2,
      title: 'Advanced Combined Multi Axis Chart',
      description: 'Gráfico combinado con múltiples ejes Y. Sirve para comparar datos con magnitudes muy diferentes (ej: lluvia y temperatura).',
      widget: FlutterEchartsAdvancedCombinedMultiAxisChartWidget(),
      isAdvanced: true,
    ),
    EchartsChartItemInfo(
      number: 3,
      title: 'Advanced Funnel Chart',
      description: 'Gráfico de embudo. Usado comúnmente para representar etapas en procesos de ventas o conversión.',
      widget: FlutterEchartsAdvancedFunnelChartWidget(),
      isAdvanced: true,
    ),
    EchartsChartItemInfo(
      number: 4,
      title: 'Advanced Heatmap Chart',
      description: 'Mapa de calor. Ideal para mostrar la densidad o concentración de datos en una matriz.',
      widget: FlutterEchartsAdvancedHeatmapChartWidget(),
      isAdvanced: true,
    ),
    EchartsChartItemInfo(
      number: 5,
      title: 'Advanced Realtime Stream Chart',
      description: 'Gráfico de transmisión en tiempo real. Utilizado para monitorear datos que cambian constantemente.',
      widget: FlutterEchartsAdvancedRealtimeStreamChartWidget(),
      isAdvanced: true,
    ),
    EchartsChartItemInfo(
      number: 6,
      title: 'Advanced Sankey Chart',
      description: 'Diagrama de Sankey. Visualiza flujos, transferencias y energía entre diferentes etapas o nodos.',
      widget: FlutterEchartsAdvancedSankeyChartWidget(),
      isAdvanced: true,
    ),
    EchartsChartItemInfo(
      number: 7,
      title: 'Advanced Treemap Chart',
      description: 'Mapa de árbol. Permite representar de forma compacta y visual estructuras de datos jerárquicas.',
      widget: FlutterEchartsAdvancedTreemapChartWidget(),
      isAdvanced: true,
    ),
    EchartsChartItemInfo(
      number: 8,
      title: 'Advanced Waterfall Chart',
      description: 'Gráfico de cascada. Perfecto para ilustrar cómo un valor inicial se ve afectado por valores intermedios.',
      widget: FlutterEchartsAdvancedWaterfallChartWidget(),
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

  void _openDetailDialog(EchartsChartItemInfo item) {
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
            Icon(Icons.pie_chart, size: 28),
            SizedBox(width: 12),
            Text(
              'Flutter Echarts Showcase',
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

  Widget _buildChartGrid(List<EchartsChartItemInfo> items) {
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
            mainAxisExtent: 400,
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
                      maxLines: 2,
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
