import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Details'),
        actions: [
          AssetContextMenu(id: id),

          const Gap(8),
        ],
      ),
      body: AsyncBuilder(
        asyncValue: assetAsync,
        builder: (asset) {
          final isPending = asset.status == .pendingApproval;
          final canApprove = isPrivileged;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  physics: kScrollPhysics,
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
                        _DetailRow(label: 'Serial Number', value: asset.serialNumber),
                        _DetailRow(label: 'Category', value: asset.category?.name),
                        _DetailRow(label: 'Location', value: asset.location?.name),
                        _DetailRow(label: 'Department', value: asset.department?.name),
                      ],
                    ),
                    const Gap(Insets.lg),

                    Text('Purchase Information', style: context.text.titleMedium?.bold),
                    const Gap(Insets.md),
                    _DetailCard(
                      children: [
                        _DetailRow(label: 'Vendor', value: asset.vendor),
                        _DetailRow(label: 'Quantity', value: asset.quantity.toString()),
                        _DetailRow(label: 'Purchase Price', value: asset.purchasePrice.currency()),
                        _DetailRow(label: 'Purchase Date', value: asset.purchaseDate),
                        _DetailRow(label: 'Expire Date', value: asset.expireDate),
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
  final String? value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final hasValue =
        value != null && value!.isNotEmpty && value != 'N/A' && value != 'Uncategorized' && value != 'Unassigned';
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
            child: Text(
              hasValue ? value! : '--',
              style: context.text.bodyMedium?.copyWith(
                fontWeight: hasValue ? FontWeight.bold : FontWeight.normal,
                color: hasValue ? context.colors.onSurface : context.colors.outline,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
