import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HighChartDataService {
  static Map<String, dynamic>? _cache;

  static Future<Map<String, dynamic>> loadData() async {
    if (_cache != null) return _cache!;
    final jsonString = await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/graficos_data.json',
    );
    _cache = json.decode(jsonString) as Map<String, dynamic>;
    return _cache!;
  }
}