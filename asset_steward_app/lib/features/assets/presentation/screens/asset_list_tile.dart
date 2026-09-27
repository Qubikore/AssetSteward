import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';
import 'package:screwdriver/screwdriver.dart';

class AssetListTile extends ConsumerWidget {
  final AssetModel asset;

  const AssetListTile({super.key, required this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AssetModel(:purchasePrice, :serialNumber, :expireDate, :category, :location, :department) = asset;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Slidable(
        key: ValueKey(asset.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.push(RPaths.createAsset.path, extra: asset);
              },
              backgroundColor: context.colors.primaryContainer,
              foregroundColor: context.colors.onPrimaryContainer,
              icon: HIStroke.edit03,
              label: 'Edit',
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            ),
            SlidableAction(
              onPressed: (context) async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Location'),
                    content: Text('Are you sure you want to delete ${asset.name}?'),
                    actions: [
                      TextButton(onPressed: () => context.nPop(false), child: const Text('Cancel')),
                      FilledButton(
                        onPressed: () => context.nPop(true),
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
                  await ref.read(assetsCtrlProvider.notifier).deleteAsset(asset.id);
                }
              },
              backgroundColor: context.colors.error,
              foregroundColor: context.colors.onError,
              icon: HIStroke.delete01,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outlineVariant.op(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: Text(asset.name, style: context.text.titleMedium, maxLines: 1, overflow: .ellipsis),
                        ),
                        Text(asset.purchasePrice.currency(), style: context.text.titleMedium),
                      ],
                    ),
                    const Gap(2),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: asset.status.sentenceCase,
                            style: context.text.bodySmall?.textColor(
                              asset.isAvailable ? Colors.green.shade600 : context.colors.outline,
                            ),
                          ),
                        ],
                      ),
                      style: context.text.labelSmall,
                    ),

                    const Gap(4),

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
                                TextSpan(text: '  ${asset.category!.name}'),
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
                                TextSpan(text: '  ${asset.department!.name}'),
                              ],
                            ),
                            style: context.text.labelSmall?.textColor(context.colors.outline),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
