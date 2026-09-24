import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const MetricCard({super.key, required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outlineVariant.op(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: context.colors.onPrimaryContainer, size: 20),
          ),
          const Gap(Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: context.text.bodySmall?.textColor(context.colors.onSurfaceVariant), maxLines: 1),
                Text(value, style: context.text.titleMedium?.bold, maxLines: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
