import 'package:flutter/material.dart';

class ChartFilterBar extends StatelessWidget {
  const ChartFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Chip(label: Text('All')),
        SizedBox(width: 8),
        Chip(label: Text('Basic')),
        SizedBox(width: 8),
        Chip(label: Text('Advanced')),
      ],
    );
  }
}
