import 'dart:convert';
import 'package:flutter/services.dart';

class SyncfusionDataService {
  static Future<Map<String, dynamic>> loadData() async {
    final String response = await rootBundle.loadString('lib/features/high_chart/presentation/Data/graficos_data.json');
    return json.decode(response);
  }
}
