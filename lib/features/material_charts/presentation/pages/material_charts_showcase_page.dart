import 'package:flutter/material.dart';

class MaterialChartsShowcasePage extends StatelessWidget {
  const MaterialChartsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MaterialCharts Showcase')),
      body: const Center(child: Text('MaterialCharts Charts View')),
    );
  }
}
