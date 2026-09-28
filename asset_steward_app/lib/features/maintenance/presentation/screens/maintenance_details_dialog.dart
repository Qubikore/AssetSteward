import 'package:asset_steward_app/features/maintenance/data/models/maintenance_response.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';
import 'package:screwdriver/screwdriver.dart';

class MaintenanceDetailsDialog extends HookConsumerWidget {
  final MaintenanceResponse record;

  const MaintenanceDetailsDialog({super.key, required this.record});

  static Future<void> show(BuildContext context, MaintenanceResponse record) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (context) => MaintenanceDetailsDialog(record: record),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = record.status == .completed;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.9,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, sc) {
        return ListView(
          controller: sc,
          physics: kScrollPhysics,
          padding: const EdgeInsets.all(20.0).copyWith(top: 0),
          children: [
            Text('Maintenance Details', style: context.text.titleLarge?.bold),
            const Gap(24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.colors.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(HIStroke.repair, color: context.colors.onPrimaryContainer, size: 28),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.assetName ?? 'Unknown Asset',
                        style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(4),
                      Text(
                        'Asset ID: ${record.assetId}',
                        style: context.text.bodyMedium?.textColor(context.colors.outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(18),
            Text('Information', style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Gap(8),
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
                    value: (record.status?.name ?? 'Unknown').sentenceCase,
                    valueColor: isCompleted ? Colors.green : Colors.orange,
                  ),
                  _buildDivider(context),
                  _DetailRow(icon: HIStroke.cash01, title: 'Cost', value: (record.cost ?? 0).currency()),
                  _buildDivider(context),
                  _DetailRow(icon: HIStroke.userCircle, title: 'Provider', value: record.provider ?? 'N/A'),
                  if (record.startDate.isNotNullOrBlank) ...[
                    _buildDivider(context),
                    _DetailRow(icon: HIStroke.calendar01, title: 'Start Date', value: record.startDate!),
                  ],
                  if (record.endDate.isNotNullOrBlank) ...[
                    _buildDivider(context),
                    _DetailRow(icon: HIStroke.calendar01, title: 'End Date', value: record.endDate!),
                  ],
                ],
              ),
            ),
            const Gap(18),
            Text('Description', style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Gap(8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.surfaceContainerHighest.op(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.outlineVariant.op(0.5)),
              ),
              child: Text(
                record.description.isNotNullOrBlank ? record.description! : 'No description provided.',
                style: context.text.bodyMedium?.copyWith(height: 1.5),
              ),
            ),
          ],
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
          const Gap(8),
          Text(title, style: context.text.bodyMedium?.copyWith(color: context.colors.outline)),
          const Gap(12),
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
