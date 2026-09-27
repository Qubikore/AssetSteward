import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/profile/data/models/profile_data.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

class AssetDetailsPage extends HookConsumerWidget {
  final int id;

  const AssetDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetAsync = ref.watch(assetDetailsCtrlProvider(id));
    final profileAsync = ref.watch(profileCtrlProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Details'),
        actions: [
          assetAsync.when(
            data: (asset) => ContextMenu(
              alignment: ContextMenuAlignment.end,
              items: [
                ContextMenuAction(
                  title: 'Assign',
                  leading: const Icon(HIStroke.userAdd01),
                  onTap: () => Toast.showInfo('Assign feature coming soon'),
                ),
                ContextMenuAction(
                  title: 'Transfer',
                  leading: const Icon(HIStroke.arrowDataTransferHorizontal),
                  onTap: () => Toast.showInfo('Transfer feature coming soon'),
                ),
                ContextMenuAction(
                  title: 'Print Label',
                  leading: const Icon(HIStroke.printer),
                  onTap: () => Toast.showInfo('Print Label feature coming soon'),
                ),
                ContextMenuAction(
                  title: 'Start Maintenance',
                  leading: const Icon(HIStroke.settings02),
                  onTap: () => Toast.showInfo('Maintenance feature coming soon'),
                ),
                const ContextMenuDivider(),
                ContextMenuAction(
                  title: 'Edit Asset',
                  leading: const Icon(HIStroke.edit02),
                  onTap: () => context.push(RPaths.createAsset.path, extra: asset),
                ),
                ContextMenuAction(
                  title: 'Delete Asset',
                  leading: const Icon(HIStroke.delete02),
                  isDestructive: true,
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Asset'),
                        content: const Text('Are you sure you want to delete this asset?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                          FilledButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: FilledButton.styleFrom(
                              backgroundColor: context.colors.error,
                              foregroundColor: context.colors.onError,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      final success = await ref.read(assetsCtrlProvider.notifier).deleteAsset(id);
                      if (success && context.mounted) {
                        context.pop();
                      }
                    }
                  },
                ),
              ],
              buttonBuilder: (context, open) =>
                  IconButton(onPressed: open, icon: const Icon(HIStroke.moreVerticalCircle01)),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const Gap(8),
        ],
      ),
      body: AsyncBuilder(
        asyncValue: assetAsync,
        builder: (asset) {
          final isPending = asset.status == AssetStatus.pendingApproval;
          final profile = profileAsync.value;
          final canApprove = profile != null && (profile.role == UserRole.superAdmin || profile.role == UserRole.hr);

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(Insets.lg),
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
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(color: context.colors.primaryContainer, shape: BoxShape.circle),
                            child: Icon(HIStroke.laptopProgramming, size: 48, color: context.colors.primary),
                          ),
                          const Gap(Insets.lg),
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
                    Text('Asset Information', style: context.text.titleMedium?.bold),
                    const Gap(Insets.md),
                    _DetailCard(
                      children: [
                        _DetailRow(label: 'Asset Code', value: asset.assetCode),
                        _DetailRow(label: 'Serial Number', value: asset.serialNumber ?? 'N/A'),
                        _DetailRow(label: 'Category', value: asset.category?.name ?? 'Uncategorized'),
                        _DetailRow(label: 'Location', value: asset.location?.name ?? 'Unassigned'),
                        _DetailRow(label: 'Department', value: asset.department?.name ?? 'Unassigned'),
                      ],
                    ),
                    const Gap(Insets.lg),

                    Text('Purchase Information', style: context.text.titleMedium?.bold),
                    const Gap(Insets.md),
                    _DetailCard(
                      children: [
                        _DetailRow(label: 'Vendor', value: asset.vendor ?? 'N/A'),
                        _DetailRow(label: 'Purchase Price', value: asset.purchasePrice.currency()),
                        _DetailRow(label: 'Purchase Date', value: asset.purchaseDate),
                        _DetailRow(label: 'Expire Date', value: asset.expireDate ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
              ),

              // Fixed Bottom Action Bar (if pending approval)
              if (isPending && canApprove)
                Container(
                  padding: const EdgeInsets.all(Insets.lg).copyWith(bottom: context.mq.padding.bottom + Insets.lg),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: Border(top: BorderSide(color: context.colors.outlineVariant.op(0.2))),
                    boxShadow: [BoxShadow(color: Colors.black.op(0.05), blurRadius: 10, offset: const Offset(0, -4))],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Reject Logic (If API supported it, we'd call it here)
                            Toast.showInfo('Reject feature coming soon');
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.colors.error,
                            side: BorderSide(color: context.colors.error),
                          ),
                          child: const Text('Reject'),
                        ),
                      ),
                      const Gap(Insets.md),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            ref.read(assetDetailsCtrlProvider(id).notifier).approve();
                          },
                          child: const Text('Approve'),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final List<Widget> children;

  const _DetailCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.3)),
      ),
      child: Column(children: children),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: context.text.bodyMedium?.bold, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
