import 'package:asset_steward_app/features/home/data/models/asset_utilization.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class UtilizationTile extends StatelessWidget {
  final AssetUtilization util;

  const UtilizationTile({super.key, required this.util});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outlineVariant.op(0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: context.colors.secondaryContainer, shape: BoxShape.circle),
            child: Icon(HIStroke.laptopProgramming, color: context.colors.onSecondaryContainer),
          ),
          const Gap(Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  util.assetName,
                  style: context.text.titleSmall?.bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(util.assetCode, style: context.text.bodySmall?.textColor(context.colors.onSurfaceVariant)),
              ],
            ),
          ),
          const Gap(Insets.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatBadge(icon: HIStroke.userAdd01, label: '${util.assignmentCount} uses'),
              const Gap(4),
              StatBadge(icon: HIStroke.settings01, label: '${util.maintenanceCount} fixes'),
            ],
          ),
        ],
      ),
    );
  }
}

class StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const StatBadge({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: context.colors.onSurfaceVariant),
        const Gap(4),
        Text(label, style: context.text.labelSmall?.medium.textColor(context.colors.onSurfaceVariant)),
      ],
    );
  }
}
