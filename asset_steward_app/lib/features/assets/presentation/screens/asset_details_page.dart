import 'package:asset_steward_app/features/assets/data/models/asset_history_model.dart';
import 'package:asset_steward_app/features/assets/data/models/assignment_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

import '../../../../widgets/collapsible_section.dart';
import 'asset_context_menu.dart';

class AssetDetailsPage extends HookConsumerWidget {
  final int id;

  const AssetDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetAsync = ref.watch(assetDetailsCtrlProvider(id));
    final profileAsync = ref.watch(profileCtrlProvider);
    final profile = profileAsync.value;
    final isPrivileged = profile?.isPrivileged ?? false;

    return AsyncBuilder(
      asyncValue: assetAsync,
      wrapWithScaffold: true,
      scaffoldTitle: 'Asset Details',
      providers: [assetDetailsCtrlProvider],
      builder: (asset) {
        final isPending = asset.status == .pendingApproval;
        final canApprove = isPrivileged;
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Asset Details'),
            actions: [
              AssetContextMenu(id: id),

              const Gap(8),
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: .min,
            children: [
              if (isPending && canApprove)
                Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: Insets.lg).copyWith(bottom: Insets.md),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: context.colors.shadow.op(0.05), blurRadius: 10, offset: const Offset(0, -4)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final reason = await showDialog<String>(
                              context: context,
                              builder: (context) => const RejectAssetDialog(),
                            );
                            if (reason != null) {
                              await ref.read(assetDetailsCtrlProvider(id).notifier).reject(reason);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: context.colors.surface,
                            foregroundColor: context.colors.error,
                            side: BorderSide(color: context.colors.error),
                          ),
                          child: const Text('Reject'),
                        ),
                      ),
                      const Gap(Insets.md),
                      Expanded(
                        child: FilledButton(
                          onPressed: () async {
                            final approved = await showDialog<bool>(
                              context: context,
                              builder: (context) => const ApproveAssetDialog(),
                            );
                            if (approved == true) {
                              await ref.read(assetDetailsCtrlProvider(id).notifier).approve();
                            }
                          },
                          child: const Text('Approve'),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(assetAssignmentsProvider);
              ref.invalidate(assetHistoryProvider);
              return ref.read(assetDetailsCtrlProvider(id).notifier).refresh();
            },
            child: ListView(
              physics: kScrollPhysics,
              padding: const EdgeInsets.all(Insets.lg).withBottomEx(),
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(Insets.lg),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.colors.outlineVariant.op3),
                  ),
                  child: Column(
                    children: [
                      Text(asset.name, style: context.text.headlineSmall?.bold, textAlign: TextAlign.center),
                      const Gap(Insets.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: asset.status.color.op(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          asset.status.name.sentenceCase,
                          style: context.text.labelMedium?.bold.textColor(asset.status.color),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Insets.lg),

                // Details Section
                CollapsibleSection(
                  title: 'Asset Information',
                  initiallyExpanded: true,
                  children: [
                    _DetailRow(label: 'Asset Code', value: asset.assetCode),
                    _DetailRow(label: 'Serial Number', value: asset.serialNumber),
                    _DetailRow(label: 'Category', value: asset.category?.name),
                    _DetailRow(label: 'Location', value: asset.location?.name),
                    _DetailRow(label: 'Department', value: asset.department?.name),
                    _DetailRow(label: 'Created By', value: asset.createdBy?.fullName),
                    _DetailRow(
                      label: 'Created Date',
                      value: asset.createdAt != null
                          ? DateTime.tryParse(asset.createdAt!)?.toRelativeTime() ?? asset.createdAt
                          : null,
                    ),
                  ],
                ),
                const Gap(Insets.lg),

                CollapsibleSection(
                  title: 'Purchase Information',
                  initiallyExpanded: true,
                  children: [
                    _DetailRow(label: 'Vendor', value: asset.vendor),
                    _DetailRow(label: 'Quantity', value: asset.quantity.toString()),
                    _DetailRow(label: 'Purchase Price', value: asset.purchasePrice.currency()),
                    _DetailRow(label: 'Purchase Date', value: asset.purchaseDate),
                    _DetailRow(label: 'Expire Date', value: asset.expireDate),
                  ],
                ),
                const Gap(Insets.lg),

                AsyncBuilder(
                  asyncValue: ref.watch(assetAssignmentsProvider(id)),
                  providers: [assetAssignmentsProvider(id)],
                  allowEmpty: true,
                  builder: (assignments) {
                    if (assignments.isEmpty) return const SizedBox.shrink();
                    return Column(
                      children: [
                        CollapsibleSection(
                          title: 'Assignments',
                          children: assignments.map((a) => _AssignmentCard(assignment: a)).toList(),
                        ),
                        const Gap(Insets.lg),
                      ],
                    );
                  },
                ),

                AsyncBuilder(
                  asyncValue: ref.watch(assetHistoryProvider(id)),
                  providers: [assetHistoryProvider(id)],
                  allowEmpty: true,
                  builder: (history) {
                    if (history.isEmpty) return const SizedBox.shrink();
                    return CollapsibleSection(
                      title: 'Asset History',
                      children: history.map((h) => _HistoryCard(history: h)).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ApproveAssetDialog extends StatelessWidget {
  const ApproveAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Approve Asset'),
      content: const Text('Are you sure you want to approve this asset?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Approve')),
      ],
    );
  }
}

class RejectAssetDialog extends HookWidget {
  const RejectAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final reasonController = useTextEditingController();
    return AlertDialog(
      title: const Text('Reject Asset'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Please provide a reason for rejection:'),
          const Gap(Insets.md),
          InputField(controller: reasonController, hintText: 'Reason...', maxLines: 5),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(context, reasonController.text.trim()),
          style: FilledButton.styleFrom(backgroundColor: context.colors.error, foregroundColor: context.colors.onError),
          child: const Text('Reject'),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;
  const _DetailRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Text(label, style: context.text.bodySmall?.copyWith(color: context.colors.outline)),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text(value ?? '--', style: context.text.bodySmall?.semiBold, textAlign: TextAlign.right)],
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;

  const _AssignmentCard({required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Insets.sm),
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, size: 20),
              const Gap(Insets.sm),
              Expanded(child: Text(assignment.assignedTo.fullName, style: context.text.bodyMedium?.bold)),
              if (assignment.returnedAtDate != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Returned', style: context.text.labelSmall),
                ),
            ],
          ),
          const Gap(Insets.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Assigned:', style: context.text.bodySmall?.textColor(context.colors.outline)),
              Text(
                assignment.assignedAtDate?.toRelativeTime() ?? assignment.assignedAt,
                style: context.text.bodySmall?.bold,
              ),
            ],
          ),
          if (assignment.returnedAtDate != null) ...[
            const Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Returned:', style: context.text.bodySmall?.textColor(context.colors.outline)),
                Text(assignment.returnedAtDate!.toRelativeTime(), style: context.text.bodySmall?.bold),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final AssetHistoryModel history;

  const _HistoryCard({required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Insets.sm),
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.history, size: 20, color: context.colors.primary),
          const Gap(Insets.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(history.action, style: context.text.bodyMedium?.bold),
                    Text(
                      DateTime.tryParse(history.timestamp)?.toRelativeTime() ?? history.timestamp,
                      style: context.text.labelSmall?.textColor(context.colors.outline),
                    ),
                  ],
                ),
                if (history.actionBy != null) ...[
                  const Gap(4),
                  Text('By: ${history.actionBy!.fullName}', style: context.text.bodySmall),
                ],
                if (history.notes != null && history.notes!.isNotEmpty) ...[
                  const Gap(4),
                  Text(history.notes!, style: context.text.bodySmall?.textColor(context.colors.outline)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
