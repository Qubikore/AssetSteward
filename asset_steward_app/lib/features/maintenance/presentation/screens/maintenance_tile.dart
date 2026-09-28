import 'package:asset_steward_app/features/maintenance/data/models/maintenance_response.dart';
import 'package:asset_steward_app/features/maintenance/presentation/controllers/maintenance_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class MaintenanceTile extends HookConsumerWidget {
  const new({super.key, required this.record});

  final MaintenanceResponse record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  record.assetName ?? 'Unknown Asset',
                  style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: record.status == MaintenanceStatus.completed
                      ? context.colors.primaryContainer
                      : context.colors.tertiaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  record.status?.name.toUpperCase() ?? 'UNKNOWN',
                  style: context.text.labelSmall?.copyWith(
                    color: record.status == MaintenanceStatus.completed
                        ? context.colors.onPrimaryContainer
                        : context.colors.onTertiaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(record.description ?? '', style: context.text.bodyMedium),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cost: \$${record.cost?.toStringAsFixed(2) ?? '0.00'}',
                style: context.text.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('Provider: ${record.provider ?? 'N/A'}', style: context.text.bodySmall),
            ],
          ),
          if (record.status != MaintenanceStatus.completed) ...[
            const Gap(16),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final notifier = ref.read(maintenanceCtrlProvider.notifier);
                  await notifier.completeMaintenance(record.id);
                },
                icon: const Icon(HIStroke.checkmarkBadge01, size: 18),
                label: const Text('Complete'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
