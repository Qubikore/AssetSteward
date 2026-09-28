import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/assign_asset_sheet.dart';
import 'package:asset_steward_app/features/maintenance/presentation/screens/start_maintenance_sheet.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AssetContextMenu extends ConsumerWidget {
  const new({super.key, this.id, this.asset});

  final int? id;
  final AssetModel? asset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileCtrlProvider).value;
    final isPrivileged = profile?.isPrivileged ?? false;

    if (asset != null) {
      return _AssetMenu(isPrivileged: isPrivileged, asset: asset!);
    }

    if (id != null) {
      final assetAsync = ref.watch(assetDetailsCtrlProvider(id!));

      return assetAsync.when(
        loading: () => const SizedBox.shrink(),
        error: (_, _) => const SizedBox.shrink(),
        data: (asset) => _AssetMenu(isPrivileged: isPrivileged, asset: asset),
      );
    }

    return const SizedBox.shrink();
  }
}

class _AssetMenu extends ConsumerWidget {
  const new({required this.isPrivileged, required this.asset});

  final bool isPrivileged;
  final AssetModel asset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = asset.id;
    return ContextMenu(
      alignment: ContextMenuAlignment.end,
      items: [
        if (isPrivileged)
          ContextMenuAction(
            title: 'Update Quantity',
            leading: const Icon(HIStroke.add01),
            onTap: () async {
              final qty = await showDialog<int>(
                context: context,
                builder: (_) => _UpdateQuantityDialog(initialQuantity: asset.quantity),
              );
              if (qty != null && context.mounted) {
                final success = await ref.read(assetDetailsCtrlProvider(id).notifier).updateAsset({'quantity': qty});
                if (success) {
                  ref.invalidate(assetDetailsCtrlProvider(id));
                }
              }
            },
          ),
        if (isPrivileged && asset.status != AssetStatus.assigned)
          ContextMenuAction(
            title: 'Assign',
            leading: const Icon(HIStroke.userAdd01),
            onTap: () => AssignAssetSheet.show(context, asset),
          ),
        if (isPrivileged && asset.status == AssetStatus.assigned)
          ContextMenuAction(
            title: 'Transfer',
            leading: const Icon(HIStroke.arrowDataTransferHorizontal),
            onTap: () => AssignAssetSheet.show(context, asset, isTransfer: true),
          ),
        ContextMenuAction(
          title: 'Start Maintenance',
          leading: const Icon(HIStroke.repair),
          onTap: () => StartMaintenanceSheet.show(context, assetId: asset.id),
        ),
        ContextMenuAction(
          title: 'Print Label',
          leading: const Icon(HIStroke.printer),
          onTap: () => Toast.showInfo('Print Label feature coming soon'),
        ),
        if (isPrivileged) ...[
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
                final success = await ref.read(assetDetailsCtrlProvider(id).notifier).deleteAsset();
                if (success && context.mounted) context.pop();
              }
            },
          ),
        ],
      ],
    );
  }
}

class _UpdateQuantityDialog extends HookWidget {
  final int initialQuantity;

  const _UpdateQuantityDialog({required this.initialQuantity});

  @override
  Widget build(BuildContext context) {
    final qtyState = useState(initialQuantity);
    final ctrl = useTextEditingController(text: initialQuantity.toString());

    return AlertDialog(
      title: const Text('Update Quantity'),
      content: Row(
        children: [
          IconButton(
            onPressed: () {
              if (qtyState.value > 0) {
                qtyState.value--;
                ctrl.text = qtyState.value.toString();
              }
            },
            icon: const Icon(HIStroke.minusSign),
          ),
          const Gap(Insets.md),
          Expanded(
            child: TextFormField(
              controller: ctrl,
              autofocus: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (v) => qtyState.value = int.tryParse(v) ?? 0,
            ),
          ),
          const Gap(Insets.md),
          IconButton(
            onPressed: () {
              qtyState.value++;
              ctrl.text = qtyState.value.toString();
            },
            icon: const Icon(HIStroke.add01),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
        FilledButton(onPressed: () => context.pop(qtyState.value), child: const Text('Save')),
      ],
    );
  }
}
