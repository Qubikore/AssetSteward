import 'package:asset_steward_app/features/maintenance/data/models/maintenance_model.dart';
import 'package:asset_steward_app/features/maintenance/presentation/controllers/maintenance_controller.dart';
import 'package:asset_steward_app/features/maintenance/presentation/screens/maintenance_details_dialog.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';
import 'package:screwdriver/screwdriver.dart';

class MaintenanceTile extends ConsumerWidget {
  final MaintenanceModel record;

  const MaintenanceTile({super.key, required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isCompleted = record.status == MaintenanceStatus.completed;

    return Slidable(
      key: ValueKey(record.id),
      enabled: !isCompleted,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.35,
        children: [
          SlidableAction(
            borderRadius: Corners.lgBorder,
            onPressed: (context) async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Complete Maintenance'),
                  content: const Text('Are you sure you want to mark this maintenance as complete?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Complete')),
                  ],
                ),
              );

              if (confirm == true) {
                final notifier = ref.read(maintenanceCtrlProvider.notifier);
                await notifier.completeMaintenance(record.id);
              }
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: HIStroke.checkmarkBadge01,
            label: 'Complete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => MaintenanceDetailsDialog.show(context, record),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outlineVariant.op(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Text(
                      record.assetName ?? 'Unknown Asset',
                      style: context.text.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text((record.cost ?? 0).currency(), style: context.text.titleMedium),
                ],
              ),
              const Gap(4),
              Text(
                (record.status?.name ?? 'Unknown').sentenceCase,
                style: context.text.bodySmall?.textColor(isCompleted ? Colors.green : Colors.orange),
              ),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (record.provider.isNotNullOrBlank)
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(HIStroke.userCircle, size: 12, color: context.colors.outline),
                                ),
                                TextSpan(text: '  ${record.provider}'),
                              ],
                            ),
                            style: context.text.labelSmall?.textColor(context.colors.outline),
                          ),
                        if (record.provider.isNotNullOrBlank && record.startDate.isNotNullOrBlank)
                          Icon(Icons.circle, size: 6, color: context.colors.outlineVariant),
                        if (record.startDate.isNotNullOrBlank)
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(HIStroke.calendar01, size: 12, color: context.colors.outline),
                                ),
                                TextSpan(text: '  ${record.startDate}'),
                              ],
                            ),
                            style: context.text.labelSmall?.textColor(context.colors.outline),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
