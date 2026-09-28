import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/maintenance/data/models/maintenance_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';
import 'package:screwdriver/screwdriver.dart';

class MaintenanceDetailsDialog extends HookConsumerWidget {
  final MaintenanceModel record;

  const MaintenanceDetailsDialog({super.key, required this.record});

  static Future<void> show(BuildContext context, MaintenanceModel record) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MaintenanceDetailsDialog(record: record),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = record.status == MaintenanceStatus.completed;
    final AssetModel(:serialNumber, :category, :location, :department) = record.asset;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, sc) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(12),
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.onSurfaceVariant.op(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(16),

              Expanded(
                child: ListView(
                  controller: sc,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(record.asset.name, style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const Gap(2),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (serialNumber.isNotNullOrBlank)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: .middle,
                                      child: Icon(HIStroke.hashtag, size: 12, color: context.colors.outline),
                                    ),
                                    TextSpan(text: '  $serialNumber'),
                                  ],
                                ),
                                style: context.text.labelSmall?.textColor(context.colors.outline),
                              ),
                            if (category != null && serialNumber.isNotNullOrBlank)
                              Icon(Icons.circle, size: 6, color: context.colors.outlineVariant),

                            if (category != null)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: .middle,
                                      child: Icon(HIStroke.tag01, size: 12, color: context.colors.outline),
                                    ),
                                    TextSpan(text: '  ${category.name}'),
                                  ],
                                ),
                                style: context.text.labelSmall?.textColor(context.colors.outline),
                              ),

                            if (category != null && department != null)
                              Icon(Icons.circle, size: 6, color: context.colors.outlineVariant),

                            if (department != null)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: .middle,
                                      child: Icon(HIStroke.building02, size: 12, color: context.colors.outline),
                                    ),
                                    TextSpan(text: '  ${department.name}'),
                                  ],
                                ),
                                style: context.text.labelSmall?.textColor(context.colors.outline),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(14),

                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.surfaceContainerHighest.op(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
                      ),
                      child: Column(
                        children: [
                          _DetailRow(
                            icon: HIStroke.checkmarkBadge01,
                            title: 'Status',
                            value: record.status.name.sentenceCase,
                            valueColor: isCompleted ? Colors.green : Colors.orange,
                          ),

                          _DetailRow(icon: HIStroke.cash01, title: 'Cost', value: record.cost.currency()),

                          _DetailRow(icon: HIStroke.userCircle, title: 'Provider', value: record.provider ?? 'N/A'),

                          if (record.startDate.isNotNullOrBlank)
                            _DetailRow(icon: HIStroke.calendar01, title: 'Start Date', value: record.startDate),

                          if (record.startedBy != null)
                            _DetailRow(
                              icon: HIStroke.userAdd01,
                              title: 'Started By',
                              value: record.startedBy?.fullName ?? 'System',
                            ),

                          if (record.endDate.isNotNullOrBlank)
                            _DetailRow(icon: HIStroke.calendar01, title: 'End Date', value: record.endDate!),

                          if (record.endedBy != null)
                            _DetailRow(
                              icon: HIStroke.userCheck01,
                              title: 'Completed By',
                              value: record.endedBy?.fullName ?? 'System',
                            ),
                        ].separatedBy(_buildDivider(context)),
                      ),
                    ),

                    const Gap(14),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceContainerHighest.op(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
                      ),
                      child: Text(
                        record.description.isNotNullOrBlank ? record.description : 'No description provided.',
                        style: context.text.bodyMedium?.copyWith(height: 1.5),
                      ),
                    ),
                    const Gap(32),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(height: 1, indent: 48, endIndent: 16, color: context.colors.outlineVariant.op(0.5));
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const _DetailRow({required this.icon, required this.title, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colors.outline),
          const Gap(12),
          Text(title, style: context.text.bodyMedium?.copyWith(color: context.colors.outline)),
          const Gap(16),
          Expanded(
            child: Text(
              value,
              style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: valueColor),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
