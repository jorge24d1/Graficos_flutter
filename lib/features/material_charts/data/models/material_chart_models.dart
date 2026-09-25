// Data models dedicated to Material Charts

class BasicChartDataPoint {
  final String label;
  final double value;
  final String? group;

  const BasicChartDataPoint({
    required this.label,
    required this.value,
    this.group,
  });
}

class MultiSeriesChartDataPoint {
  final String label;
  final List<double> values;
  final List<String> seriesNames;

  const MultiSeriesChartDataPoint({
    required this.label,
    required this.values,
    required this.seriesNames,
  });
}

class ScatterBubbleDataPoint {
  final String label;
  final double x;
  final double y;
  final double size;
  final String? category;

  const ScatterBubbleDataPoint({
    required this.label,
    required this.x,
    required this.y,
    this.size = 1.0,
    this.category,
  });
}

class RadarDataPoint {
  final String attribute;
  final double value;
  final double maxValue;

  const RadarDataPoint({
    required this.attribute,
    required this.value,
    this.maxValue = 100.0,
  });
}

class CandlestickDataPoint {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  const CandlestickDataPoint({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  bool get isBullish => close >= open;
}

class HeatmapDataPoint {
  final int xIndex; // e.g. Day of week (0-6)
  final int yIndex; // e.g. Hour of day (0-23)
  final String xLabel;
  final String yLabel;
  final double intensity; // 0.0 to 1.0

  const HeatmapDataPoint({
    required this.xIndex,
    required this.yIndex,
    required this.xLabel,
    required this.yLabel,
    required this.intensity,
  });
}

class TreemapNode {
  final String name;
  final double value;
  final String category;

  const TreemapNode({
    required this.name,
    required this.value,
    required this.category,
  });
}

class FunnelStageData {
  final String stage;
  final double value;
  final double conversionPercentage;

  const FunnelStageData({
    required this.stage,
    required this.value,
    required this.conversionPercentage,
  });
}

class WaterfallDataPoint {
  final String category;
  final double amount;
  final bool isTotal;
  final bool isSubtotal;

  const WaterfallDataPoint({
    required this.category,
    required this.amount,
    this.isTotal = false,
    this.isSubtotal = false,
  });
}

class SankeyNode {
  final String id;
  final String name;

  const SankeyNode({required this.id, required this.name});
}

class SankeyLink {
  final String sourceId;
  final String targetId;
  final double value;

  const SankeyLink({
    required this.sourceId,
    required this.targetId,
    required this.value,
  });
}

class MultiAxisDataPoint {
  final String category;
  final double barValue;
  final double lineValue;

  const MultiAxisDataPoint({
    required this.category,
    required this.barValue,
    required this.lineValue,
  });
}
