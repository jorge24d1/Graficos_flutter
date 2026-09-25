import 'package:flutter/material.dart';
import '../../data/datasources/material_charts_mock_datasource.dart';
import '../../data/models/material_chart_models.dart';

class MaterialChartsAdvancedSankeyChartWidget extends StatelessWidget {
  final Map<String, dynamic>? data;
  const MaterialChartsAdvancedSankeyChartWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final sankeyData =
        data ?? MaterialChartsMockDatasource().getSankeyChartData();
    final List<SankeyNode> nodes = sankeyData['nodes'];
    final List<SankeyLink> links = sankeyData['links'];
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Diagrama Flujo Sankey (Sankey Flow)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _SankeyPainter(
                nodes: nodes,
                links: links,
                primaryColor: theme.colorScheme.primary,
                secondaryColor: theme.colorScheme.secondary,
                tertiaryColor: theme.colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SankeyPainter extends CustomPainter {
  final List<SankeyNode> nodes;
  final List<SankeyLink> links;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  _SankeyPainter({
    required this.nodes,
    required this.links,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 3 columns layout: Source (x=0.1), Middle (x=0.5), Target (x=0.9)
    final xSrc = size.width * 0.1;
    final xMid = size.width * 0.5;
    final xTgt = size.width * 0.9;

    final nodePos = <String, Offset>{
      'src1': Offset(xSrc, size.height * 0.5),
      'node1': Offset(xMid, size.height * 0.3),
      'node2': Offset(xMid, size.height * 0.7),
      'target1': Offset(xTgt, size.height * 0.3),
      'target2': Offset(xTgt, size.height * 0.7),
    };

    // Draw flow links
    final linkPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var link in links) {
      final p1 = nodePos[link.sourceId];
      final p2 = nodePos[link.targetId];
      if (p1 != null && p2 != null) {
        linkPaint.color = primaryColor.withValues(alpha: 0.35);
        linkPaint.strokeWidth = (link.value / 2.5).clamp(3.0, 18.0);

        final path = Path()..moveTo(p1.dx, p1.dy);
        final cx1 = p1.dx + (p2.dx - p1.dx) / 2;
        path.cubicTo(cx1, p1.dy, cx1, p2.dy, p2.dx, p2.dy);

        canvas.drawPath(path, linkPaint);
      }
    }

    // Draw node boxes
    final nodePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    nodePos.forEach((id, pos) {
      final node = nodes.firstWhere((n) => n.id == id, orElse: () => SankeyNode(id: id, name: id));
      final rect = Rect.fromCenter(center: pos, width: 24, height: 40);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(6)), nodePaint);

      final textSpan = TextSpan(
        text: node.name,
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
      );
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy - 30));
    });
  }

  @override
  bool shouldRepaint(covariant _SankeyPainter oldDelegate) => true;
}
