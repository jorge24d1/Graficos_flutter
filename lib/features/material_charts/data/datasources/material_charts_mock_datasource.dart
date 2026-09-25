import '../models/material_chart_models.dart';

class MaterialChartsMockDatasource {
  // --- 12 Basic Chart Data Sets ---

  List<BasicChartDataPoint> getBarChartData() {
    return const [
      BasicChartDataPoint(label: 'Ene', value: 420),
      BasicChartDataPoint(label: 'Feb', value: 680),
      BasicChartDataPoint(label: 'Mar', value: 510),
      BasicChartDataPoint(label: 'Abr', value: 890),
      BasicChartDataPoint(label: 'May', value: 740),
      BasicChartDataPoint(label: 'Jun', value: 960),
    ];
  }

  List<BasicChartDataPoint> getLineChartData() {
    return const [
      BasicChartDataPoint(label: 'Sem 1', value: 12.5),
      BasicChartDataPoint(label: 'Sem 2', value: 18.2),
      BasicChartDataPoint(label: 'Sem 3', value: 14.8),
      BasicChartDataPoint(label: 'Sem 4', value: 24.1),
      BasicChartDataPoint(label: 'Sem 5', value: 28.6),
      BasicChartDataPoint(label: 'Sem 6', value: 35.0),
    ];
  }

  List<BasicChartDataPoint> getPieChartData() {
    return const [
      BasicChartDataPoint(label: 'Móvil', value: 45),
      BasicChartDataPoint(label: 'Web', value: 30),
      BasicChartDataPoint(label: 'Escritorio', value: 15),
      BasicChartDataPoint(label: 'Otros', value: 10),
    ];
  }

  List<BasicChartDataPoint> getDonutChartData() {
    return const [
      BasicChartDataPoint(label: 'Ventas Directas', value: 40),
      BasicChartDataPoint(label: 'Marketing Digital', value: 25),
      BasicChartDataPoint(label: 'Afiliados', value: 20),
      BasicChartDataPoint(label: 'Redes Sociales', value: 15),
    ];
  }

  List<BasicChartDataPoint> getAreaChartData() {
    return const [
      BasicChartDataPoint(label: 'Q1', value: 1200),
      BasicChartDataPoint(label: 'Q2', value: 1900),
      BasicChartDataPoint(label: 'Q3', value: 1600),
      BasicChartDataPoint(label: 'Q4', value: 2700),
    ];
  }

  List<ScatterBubbleDataPoint> getScatterChartData() {
    return const [
      ScatterBubbleDataPoint(label: 'Item A', x: 10, y: 25),
      ScatterBubbleDataPoint(label: 'Item B', x: 20, y: 45),
      ScatterBubbleDataPoint(label: 'Item C', x: 35, y: 30),
      ScatterBubbleDataPoint(label: 'Item D', x: 50, y: 80),
      ScatterBubbleDataPoint(label: 'Item E', x: 65, y: 60),
      ScatterBubbleDataPoint(label: 'Item F', x: 80, y: 95),
    ];
  }

  List<ScatterBubbleDataPoint> getBubbleChartData() {
    return const [
      ScatterBubbleDataPoint(label: 'App Mobile', x: 15, y: 70, size: 45, category: 'Tech'),
      ScatterBubbleDataPoint(label: 'E-commerce', x: 30, y: 85, size: 60, category: 'Retail'),
      ScatterBubbleDataPoint(label: 'Fintech', x: 45, y: 60, size: 35, category: 'Finance'),
      ScatterBubbleDataPoint(label: 'Salud App', x: 60, y: 90, size: 50, category: 'Health'),
      ScatterBubbleDataPoint(label: 'EdTech', x: 75, y: 50, size: 30, category: 'Education'),
    ];
  }

  List<RadarDataPoint> getRadarChartData() {
    return const [
      RadarDataPoint(attribute: 'Rendimiento', value: 88),
      RadarDataPoint(attribute: 'Seguridad', value: 95),
      RadarDataPoint(attribute: 'Usabilidad', value: 75),
      RadarDataPoint(attribute: 'Escalabilidad', value: 90),
      RadarDataPoint(attribute: 'Diseño UI', value: 82),
      RadarDataPoint(attribute: 'Soporte', value: 70),
    ];
  }

  double getGaugeChartValue() {
    return 76.4; // Percentage scale 0-100
  }

  List<BasicChartDataPoint> getSplineChartData() {
    return const [
      BasicChartDataPoint(label: '00:00', value: 20),
      BasicChartDataPoint(label: '04:00', value: 12),
      BasicChartDataPoint(label: '08:00', value: 45),
      BasicChartDataPoint(label: '12:00', value: 85),
      BasicChartDataPoint(label: '16:00', value: 65),
      BasicChartDataPoint(label: '20:00', value: 40),
      BasicChartDataPoint(label: '23:59', value: 25),
    ];
  }

  List<MultiSeriesChartDataPoint> getStackedBarChartData() {
    return const [
      MultiSeriesChartDataPoint(
        label: 'Trim 1',
        values: [300, 200, 150],
        seriesNames: ['Producto A', 'Producto B', 'Producto C'],
      ),
      MultiSeriesChartDataPoint(
        label: 'Trim 2',
        values: [400, 320, 210],
        seriesNames: ['Producto A', 'Producto B', 'Producto C'],
      ),
      MultiSeriesChartDataPoint(
        label: 'Trim 3',
        values: [350, 410, 290],
        seriesNames: ['Producto A', 'Producto B', 'Producto C'],
      ),
      MultiSeriesChartDataPoint(
        label: 'Trim 4',
        values: [520, 480, 390],
        seriesNames: ['Producto A', 'Producto B', 'Producto C'],
      ),
    ];
  }

  List<BasicChartDataPoint> getSteppedLineChartData() {
    return const [
      BasicChartDataPoint(label: 'Fase 1', value: 10),
      BasicChartDataPoint(label: 'Fase 2', value: 25),
      BasicChartDataPoint(label: 'Fase 3', value: 25),
      BasicChartDataPoint(label: 'Fase 4', value: 50),
      BasicChartDataPoint(label: 'Fase 5', value: 75),
      BasicChartDataPoint(label: 'Fase 6', value: 100),
    ];
  }

  // --- 8 Advanced Chart Data Sets ---

  List<CandlestickDataPoint> getCandlestickChartData() {
    final now = DateTime.now();
    return [
      CandlestickDataPoint(
        date: now.subtract(const Duration(days: 6)),
        open: 150.0,
        high: 155.0,
        low: 148.0,
        close: 153.5,
      ),
      CandlestickDataPoint(
        date: now.subtract(const Duration(days: 5)),
        open: 153.5,
        high: 158.0,
        low: 152.0,
        close: 151.0,
      ),
      CandlestickDataPoint(
        date: now.subtract(const Duration(days: 4)),
        open: 151.0,
        high: 162.0,
        low: 150.5,
        close: 160.2,
      ),
      CandlestickDataPoint(
        date: now.subtract(const Duration(days: 3)),
        open: 160.2,
        high: 164.0,
        low: 157.0,
        close: 158.0,
      ),
      CandlestickDataPoint(
        date: now.subtract(const Duration(days: 2)),
        open: 158.0,
        high: 166.5,
        low: 157.5,
        close: 165.0,
      ),
      CandlestickDataPoint(
        date: now.subtract(const Duration(days: 1)),
        open: 165.0,
        high: 170.0,
        low: 163.0,
        close: 168.5,
      ),
    ];
  }

  List<HeatmapDataPoint> getHeatmapChartData() {
    final days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie'];
    final hours = ['08:00', '11:00', '14:00', '17:00', '20:00'];
    final List<HeatmapDataPoint> points = [];

    final intensities = [
      [0.2, 0.4, 0.8, 0.6, 0.3],
      [0.3, 0.7, 0.9, 0.8, 0.4],
      [0.1, 0.5, 0.6, 0.9, 0.5],
      [0.4, 0.8, 1.0, 0.7, 0.2],
      [0.2, 0.3, 0.5, 0.4, 0.1],
    ];

    for (int d = 0; d < days.length; d++) {
      for (int h = 0; h < hours.length; h++) {
        points.add(HeatmapDataPoint(
          xIndex: d,
          yIndex: h,
          xLabel: days[d],
          yLabel: hours[h],
          intensity: intensities[d][h],
        ));
      }
    }
    return points;
  }

  List<TreemapNode> getTreemapChartData() {
    return const [
      TreemapNode(name: 'Tecnología', value: 450, category: 'Hardware'),
      TreemapNode(name: 'Software UI', value: 320, category: 'Software'),
      TreemapNode(name: 'Cloud Services', value: 280, category: 'Infrastructure'),
      TreemapNode(name: 'Marketing SEO', value: 190, category: 'Promotions'),
      TreemapNode(name: 'Ventas B2B', value: 160, category: 'Sales'),
      TreemapNode(name: 'Soporte Cliente', value: 120, category: 'Services'),
    ];
  }

  List<FunnelStageData> getFunnelChartData() {
    return const [
      FunnelStageData(stage: 'Visitas a la Web', value: 10000, conversionPercentage: 100),
      FunnelStageData(stage: 'Registro de Usuario', value: 4500, conversionPercentage: 45),
      FunnelStageData(stage: 'Añadido al Carrito', value: 2200, conversionPercentage: 22),
      FunnelStageData(stage: 'Checkout Iniciado', value: 1200, conversionPercentage: 12),
      FunnelStageData(stage: 'Compra Completada', value: 650, conversionPercentage: 6.5),
    ];
  }

  List<WaterfallDataPoint> getWaterfallChartData() {
    return const [
      WaterfallDataPoint(category: 'Ingresos Brutos', amount: 5000),
      WaterfallDataPoint(category: 'Costo de Ventas', amount: -1800),
      WaterfallDataPoint(category: 'Gastos Operativos', amount: -1200),
      WaterfallDataPoint(category: 'Impuestos', amount: -400),
      WaterfallDataPoint(category: 'Ganancia Neta', amount: 1600, isTotal: true),
    ];
  }

  Map<String, dynamic> getSankeyChartData() {
    final nodes = [
      const SankeyNode(id: 'src1', name: 'Presupuesto Inicial'),
      const SankeyNode(id: 'node1', name: 'I+D'),
      const SankeyNode(id: 'node2', name: 'Marketing'),
      const SankeyNode(id: 'target1', name: 'Producto A'),
      const SankeyNode(id: 'target2', name: 'Producto B'),
    ];

    final links = [
      const SankeyLink(sourceId: 'src1', targetId: 'node1', value: 60),
      const SankeyLink(sourceId: 'src1', targetId: 'node2', value: 40),
      const SankeyLink(sourceId: 'node1', targetId: 'target1', value: 40),
      const SankeyLink(sourceId: 'node1', targetId: 'target2', value: 20),
      const SankeyLink(sourceId: 'node2', targetId: 'target1', value: 15),
      const SankeyLink(sourceId: 'node2', targetId: 'target2', value: 25),
    ];

    return {'nodes': nodes, 'links': links};
  }

  List<MultiAxisDataPoint> getCombinedMultiAxisChartData() {
    return const [
      MultiAxisDataPoint(category: 'Ene', barValue: 120, lineValue: 12.5),
      MultiAxisDataPoint(category: 'Feb', barValue: 180, lineValue: 15.0),
      MultiAxisDataPoint(category: 'Mar', barValue: 240, lineValue: 22.8),
      MultiAxisDataPoint(category: 'Abr', barValue: 200, lineValue: 18.4),
      MultiAxisDataPoint(category: 'May', barValue: 310, lineValue: 29.1),
      MultiAxisDataPoint(category: 'Jun', barValue: 280, lineValue: 26.5),
    ];
  }
}
