import 'package:flutter/material.dart';

class EchartsShowcasePage extends StatelessWidget {
  const EchartsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Echarts Showcase')),
      body: const Center(child: Text('Echarts Charts View')),
    );
  }
}
