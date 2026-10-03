import 'package:flutter/material.dart';

/// Componente reutilizable para presentar la información analítica y educativa
/// asociada a cada gráfico de Highcharts.
///
/// Presenta de forma estructurada:
/// - Título del tipo de gráfico
/// - Descripción (qué representa o qué hace)
/// - ¿Para qué sirve? (tipo de datos, escenarios y casos de uso)
/// - Interpretación (análisis de tendencias, patrones, variaciones y anomalías)
class HighChartDescriptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String useCases;
  final String interpretation;
  final IconData? icon;

  const HighChartDescriptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.useCases,
    required this.interpretation,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const accentColor = Color(0xFF0086D4);

    return Container(
      margin: const EdgeInsets.fromLTRB(14, 4, 14, 14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera con título del gráfico y etiqueta de ficha educativa
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon ?? Icons.analytics_outlined,
                    size: 18,
                    color: accentColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'Ficha Educativa',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(
              height: 1,
              thickness: 1,
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),

            // 1. Descripción
            _buildSection(
              context: context,
              icon: Icons.info_outline_rounded,
              label: 'Descripción:',
              content: description,
              iconColor: const Color(0xFF0288D1),
            ),
            const SizedBox(height: 10),

            // 2. ¿Para qué sirve?
            _buildSection(
              context: context,
              icon: Icons.lightbulb_outline_rounded,
              label: '¿Para qué sirve?',
              content: useCases,
              iconColor: const Color(0xFFF57C00),
            ),
            const SizedBox(height: 10),

            // 3. Interpretación
            _buildSection(
              context: context,
              icon: Icons.insights_rounded,
              label: 'Interpretación:',
              content: interpretation,
              iconColor: const Color(0xFF2E7D32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String content,
    required Color iconColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.45,
                color: colorScheme.onSurface,
              ),
              children: [
                TextSpan(
                  text: '$label ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: content,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
