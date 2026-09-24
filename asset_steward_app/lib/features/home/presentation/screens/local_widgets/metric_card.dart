import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const MetricCard({super.key, required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.colors.primary, size: 24),
          const Gap(Insets.sm),
          Text(title, style: context.text.bodyMedium?.medium.textColor(context.colors.onSurfaceVariant)),
          const Gap(4),
          Text(value.toString(), style: context.text.headlineSmall?.bold),
        ],
      ),
    );
  }
}
