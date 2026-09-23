import 'package:flutter/material.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chart Showcase Dashboard')),
      body: const Center(child: Text('Select a library feature to view charts')),
    );
  }
}
