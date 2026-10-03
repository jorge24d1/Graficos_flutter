import 'package:flutter/material.dart';

class ChartCardContainer extends StatelessWidget {
  final String title;
  final Widget chart;

  const ChartCardContainer({
    super.key,
    required this.title,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Expanded(child: chart),
          ],
        ),
      ),
    );
  }
}
