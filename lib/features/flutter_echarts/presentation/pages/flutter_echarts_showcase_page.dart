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

class FlutterEchartsShowcasePage extends StatelessWidget {
  const FlutterEchartsShowcasePage({super.key});

  Widget _buildChartCard(BuildContext context, String title, Widget chart) {
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
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Echarts Showcase'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Básicos (12)'),
              Tab(text: 'Avanzados (8)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildChartCard(context, 'Basic Bar Chart', FlutterEchartsBasicBarChartWidget()),
                _buildChartCard(context, 'Basic Line Chart', FlutterEchartsBasicLineChartWidget()),
                _buildChartCard(context, 'Basic Pie Chart', FlutterEchartsBasicPieChartWidget()),
                _buildChartCard(context, 'Basic Donut Chart', FlutterEchartsBasicDonutChartWidget()),
                _buildChartCard(context, 'Basic Area Chart', FlutterEchartsBasicAreaChartWidget()),
                _buildChartCard(context, 'Basic Gauge Chart', FlutterEchartsBasicGaugeChartWidget()),
                _buildChartCard(context, 'Basic Radar Chart', FlutterEchartsBasicRadarChartWidget()),
                _buildChartCard(context, 'Basic Scatter Chart', FlutterEchartsBasicScatterChartWidget()),
                _buildChartCard(context, 'Basic Bubble Chart', FlutterEchartsBasicBubbleChartWidget()),
                _buildChartCard(context, 'Basic Spline Chart', FlutterEchartsBasicSplineChartWidget()),
                _buildChartCard(context, 'Basic Stacked Bar Chart', FlutterEchartsBasicStackedBarChartWidget()),
                _buildChartCard(context, 'Basic Stepped Line Chart', FlutterEchartsBasicSteppedLineChartWidget()),
              ],
            ),
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildChartCard(context, 'Advanced Candlestick Chart', FlutterEchartsAdvancedCandlestickChartWidget()),
                _buildChartCard(context, 'Advanced Combined Multi Axis Chart', FlutterEchartsAdvancedCombinedMultiAxisChartWidget()),
                _buildChartCard(context, 'Advanced Funnel Chart', FlutterEchartsAdvancedFunnelChartWidget()),
                _buildChartCard(context, 'Advanced Heatmap Chart', FlutterEchartsAdvancedHeatmapChartWidget()),
                _buildChartCard(context, 'Advanced Realtime Stream Chart', FlutterEchartsAdvancedRealtimeStreamChartWidget()),
                _buildChartCard(context, 'Advanced Sankey Chart', FlutterEchartsAdvancedSankeyChartWidget()),
                _buildChartCard(context, 'Advanced Treemap Chart', FlutterEchartsAdvancedTreemapChartWidget()),
                _buildChartCard(context, 'Advanced Waterfall Chart', FlutterEchartsAdvancedWaterfallChartWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
