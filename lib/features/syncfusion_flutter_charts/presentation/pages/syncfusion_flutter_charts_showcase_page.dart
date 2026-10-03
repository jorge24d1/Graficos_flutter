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
  final String idealFor;
  final Widget widget;
  final bool isAdvanced;

  const SfChartItemInfo({
    required this.title,
    required this.description,
    required this.idealFor,
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
      description:
          'Representa datos cuantitativos mediante barras rectangulares horizontales cuya longitud es proporcional al valor de cada categoría, facilitando la comparación entre elementos independientes.',
      idealFor:
          'Es ideal para comparar métricas numéricas discretas (como ventas por ciudad, inventario por sucursal o desempeño individual) especialmente cuando los nombres de las categorías son largos o se desea ordenar de mayor a menor jerarquía.',
      widget: SyncfusionFlutterChartsBasicBarChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Line Chart',
      description:
          'Muestra la evolución de uno o más valores a lo largo del tiempo conectando puntos de datos con líneas continuas. Permite visualizar tendencias, variaciones estacionales y comportamientos cíclicos de manera clara y directa.',
      idealFor:
          'Es ideal para representar series temporales como ventas mensuales, temperatura diaria o cotizaciones bursátiles, donde importa ver la dirección y velocidad del cambio a lo largo de un período definido.',
      widget: SyncfusionFlutterChartsBasicLineChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Pie Chart',
      description:
          'Presenta la distribución proporcional de categorías dentro de un todo mediante sectores circulares. Cada sector representa el porcentaje que corresponde a su categoría respecto al total acumulado.',
      idealFor:
          'Es ideal cuando se tienen pocas categorías (máximo 5-6) y se desea transmitir de forma rápida qué fracción del total ocupa cada parte, como la participación de mercado por empresa o el desglose de un presupuesto.',
      widget: SyncfusionFlutterChartsBasicPieChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Donut Chart',
      description:
          'Variante del gráfico circular con un espacio vacío en el centro que puede usarse para mostrar un valor resumen, un KPI o una etiqueta destacada. Mejora la legibilidad respecto al Pie Chart al reducir la distorsión visual del área.',
      idealFor:
          'Es ideal para dashboards ejecutivos donde se desea mostrar la distribución de categorías junto con un indicador central clave, como el porcentaje total de cumplimiento o el valor global de ventas.',
      widget: SyncfusionFlutterChartsBasicDonutChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Area Chart',
      description:
          'Extiende el gráfico de líneas rellenando el área bajo la curva con color o gradiente. Esta representación enfatiza el volumen acumulado de los datos y hace más evidente la magnitud de los cambios en el tiempo.',
      idealFor:
          'Es ideal para visualizar el volumen acumulado de métricas en el tiempo, como ingresos acumulados, usuarios activos o consumo energético, especialmente cuando se quiere resaltar diferencias de magnitud entre períodos.',
      widget: SyncfusionFlutterChartsBasicAreaChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Scatter Plot',
      description:
          'Muestra la relación entre dos variables numéricas distribuyendo puntos en un plano cartesiano. Cada punto representa una observación individual, permitiendo detectar correlaciones, agrupaciones y valores atípicos (outliers).',
      idealFor:
          'Es ideal para analizar la correlación entre variables como edad y salario, horas de estudio y calificación, o temperatura y consumo, cuando se cuenta con un conjunto de observaciones individuales que se desea explorar estadísticamente.',
      widget: SyncfusionFlutterChartsBasicScatterChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Bubble Chart',
      description:
          'Extiende el Scatter Plot añadiendo una tercera dimensión representada por el tamaño de cada burbuja. Permite visualizar simultáneamente tres variables cuantitativas por cada punto de datos en el plano.',
      idealFor:
          'Es ideal para comparar entidades en tres dimensiones al mismo tiempo, como relacionar el volumen de ventas, el margen de ganancia y el número de clientes de distintos productos o regiones en un solo vistazo.',
      widget: SyncfusionFlutterChartsBasicBubbleChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Radar Chart',
      description:
          'Representa múltiples variables cuantitativas sobre ejes que parten desde un centro común, formando un polígono. Permite comparar perfiles completos de varios sujetos o entidades en una sola vista.',
      idealFor:
          'Es ideal para comparar el rendimiento de varios elementos en múltiples dimensiones a la vez, como habilidades de vendedores, atributos de productos competidores o indicadores de desempeño en diferentes áreas de negocio.',
      widget: SyncfusionFlutterChartsBasicRadarChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Gauge Chart',
      description:
          'Representa un valor único dentro de un rango definido mediante un indicador radial tipo velocímetro. Incluye zonas de color para indicar niveles de alerta (bajo, medio, alto) y permite una lectura instantánea del estado de un indicador.',
      idealFor:
          'Es ideal para monitorear KPIs puntuales como porcentaje de cumplimiento de meta, nivel de satisfacción del cliente o capacidad de uso de un servidor, donde la lectura inmediata del estado actual respecto a un umbral es prioritaria.',
      widget: SyncfusionFlutterChartsBasicGaugeChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Spline Chart',
      description:
          'Similar al gráfico de líneas pero utiliza interpolación de curvas Bézier para suavizar las transiciones entre puntos de datos. Esto produce una línea fluida que elimina las esquinas abruptas y da una apariencia más orgánica a los datos.',
      idealFor:
          'Es ideal cuando los datos tienen variaciones bruscas o ruido y se desea transmitir la tendencia general de forma visualmente agradable, como en series de temperatura, métricas de salud o indicadores financieros suavizados.',
      widget: SyncfusionFlutterChartsBasicSplineChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Stacked Bar Chart',
      description:
          'Apila múltiples series de datos dentro de una misma barra, mostrando tanto la contribución de cada parte como el total acumulado. Cada segmento de color representa una categoría diferente dentro de la barra.',
      idealFor:
          'Es ideal para comparar la composición interna de grupos al mismo tiempo que se compara el total entre ellos, como analizar las ventas por canal (online vs tienda) de diferentes departamentos o el desglose de gastos por área.',
      widget: SyncfusionFlutterChartsBasicStackedBarChartWidget(),
    ),
    SfChartItemInfo(
      title: 'Stepped Line Chart',
      description:
          'Conecta los puntos de datos mediante segmentos horizontales y verticales en forma de escalón, en lugar de líneas diagonales. Representa con exactitud los momentos en que un valor cambia de forma discreta y permanece constante entre cambios.',
      idealFor:
          'Es ideal para representar datos que cambian en pasos discretos y no de forma continua, como precios de tarifas, niveles de inventario, configuraciones de sistema o cualquier variable que mantiene un valor fijo hasta que ocurre un evento.',
      widget: SyncfusionFlutterChartsBasicSteppedLineChartWidget(),
    ),
  ];

  final List<SfChartItemInfo> _advancedCharts = const [
    SfChartItemInfo(
      title: 'Candlestick Chart',
      description:
          'Muestra los cuatro precios clave de un activo financiero (apertura, cierre, máximo y mínimo) en cada período mediante velas. El cuerpo de la vela indica el rango entre apertura y cierre, y las sombras muestran los extremos del período.',
      idealFor:
          'Es ideal para el análisis técnico de mercados financieros como acciones, criptomonedas o forex, donde se necesita evaluar la volatilidad, la dirección del precio y la psicología del mercado en cada período de tiempo.',
      widget: SyncfusionFlutterChartsAdvancedCandlestickChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Heatmap Chart',
      description:
          'Representa una matriz de datos bidimensional mediante variaciones de color, donde la intensidad del tono indica la magnitud del valor en cada celda. Permite identificar patrones, concentraciones y anomalías en grandes conjuntos de datos de forma intuitiva.',
      idealFor:
          'Es ideal para identificar patrones de actividad en dos dimensiones, como la frecuencia de uso por día de la semana y hora, la densidad de errores en una matriz de módulos y versiones, o la correlación entre variables en un análisis exploratorio.',
      widget: SyncfusionFlutterChartsAdvancedHeatmapChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Treemap Chart',
      description:
          'Visualiza datos jerárquicos usando rectángulos anidados donde el área de cada rectángulo es proporcional al valor que representa. Permite mostrar simultáneamente la estructura jerárquica y la magnitud relativa de cada elemento.',
      idealFor:
          'Es ideal para representar distribuciones jerárquicas como la composición de un portafolio de inversiones, la estructura de archivos en un disco, o el desglose de gastos por área, departamento y proyecto en una sola vista compacta.',
      widget: SyncfusionFlutterChartsAdvancedTreemapChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Funnel Chart',
      description:
          'Representa las etapas de un proceso secuencial donde cada nivel muestra la cantidad de elementos que avanzan a la siguiente fase. La reducción progresiva del ancho ilustra la pérdida de elementos en cada transición del proceso.',
      idealFor:
          'Es ideal para analizar procesos de conversión como embudos de ventas, flujos de onboarding de usuarios, pipelines de reclutamiento o cualquier proceso donde se necesita identificar en qué etapas se produce mayor abandono o pérdida.',
      widget: SyncfusionFlutterChartsAdvancedFunnelChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Waterfall Chart',
      description:
          'Muestra cómo valores positivos y negativos contribuyen de forma acumulativa a un resultado final. Cada barra parte desde donde terminó la anterior, haciendo visible el impacto individual de cada componente sobre el total.',
      idealFor:
          'Es ideal para explicar la variación entre dos estados como el desglose de ingresos y gastos de un período, el análisis de varianza presupuestaria o los factores que explican la diferencia entre las ventas de este año y el año anterior.',
      widget: SyncfusionFlutterChartsAdvancedWaterfallChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Sankey Flow Chart',
      description:
          'Visualiza flujos y transferencias entre nodos mediante tiras de ancho proporcional a la cantidad que fluye entre ellos. Permite ver de dónde viene y hacia dónde va cada porción de un flujo total de forma muy visual e intuitiva.',
      idealFor:
          'Es ideal para visualizar flujos de conversión entre canales de marketing, movimientos de usuarios entre secciones de una app, flujos de energía en sistemas, o cualquier relación de transferencia proporcional entre nodos en una red.',
      widget: SyncfusionFlutterChartsAdvancedSankeyChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Multi-Axis Combined Chart',
      description:
          'Combina múltiples tipos de gráficos (barras, líneas, áreas) en un solo panel con dos o más ejes Y independientes. Permite superponer métricas que tienen escalas completamente distintas sin que una distorsione la visualización de la otra.',
      idealFor:
          'Es ideal cuando se necesita correlacionar métricas con escalas muy diferentes en el mismo período, como ventas en millones y número de clientes en unidades, o temperatura en grados y consumo eléctrico en kWh en un mismo eje de tiempo.',
      widget: SyncfusionFlutterChartsAdvancedCombinedMultiAxisChartWidget(),
      isAdvanced: true,
    ),
    SfChartItemInfo(
      title: 'Realtime Stream Chart',
      description:
          'Actualiza los datos del gráfico en tiempo real a medida que llegan nuevas observaciones, desplazando el eje X automáticamente para mostrar siempre los valores más recientes. Proporciona una ventana deslizante de los últimos N puntos de datos.',
      idealFor:
          'Es ideal para monitorear métricas en tiempo real como temperatura de sensores IoT, latencia de servidores, frecuencia cardíaca de pacientes o cualquier flujo de datos continuo donde la actualización instantánea y la detección de anomalías son críticas.',
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
        final textTheme = Theme.of(context).textTheme;
        final colorScheme = Theme.of(context).colorScheme;
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Descripción ────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded,
                          size: 20, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Descripción: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: item.description),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // ─── ¿Para qué sirve? ────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lightbulb_outline_rounded,
                          size: 20, color: Colors.amber.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text: '¿Para qué sirve? ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: item.idealFor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // ─── Gráfico ─────────────────────────────────────────
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
            final colorScheme = Theme.of(context).colorScheme;
            final textTheme = Theme.of(context).textTheme;
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Cabecera ──────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8, top: 10),
                    child: Row(
                      children: [
                        // Número del gráfico
                        Container(
                          width: 28,
                          height: 28,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.title,
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.fullscreen, size: 20),
                          tooltip: 'Ver detalle',
                          onPressed: () => _openDetailDialog(item),
                        ),
                      ],
                    ),
                  ),
                  // ─── Etiqueta de información ───────────────────────
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, bottom: 8, top: 2),
                    child: GestureDetector(
                      onTap: () => _openDetailDialog(item),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.info_outline_rounded,
                              size: 14, color: colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(
                            'Clic aquí para más información del gráfico',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  // ─── Gráfico ───────────────────────────────────────
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
