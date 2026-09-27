import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/asset_context_menu.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
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
    final profile = ref.watch(profileCtrlProvider).value;
    final isPrivileged = profile?.isPrivileged ?? false;

    return GestureDetector(
      onTap: () => RPaths.assetDetails(asset.id.toString()).push(context),
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
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: asset.status.name.sentenceCase,
                              style: context.text.bodySmall?.textColor(asset.status.color),
                            ),
                            if (asset.quantity > 1)
                              TextSpan(
                                text: '   x${asset.quantity.compact()}',
                                style: context.text.bodySmall?.textColor(context.colors.outline),
                              ),
                          ],
                        ),
                        style: context.text.labelSmall,
                      ),
                    ],
                  ),

                  // const Gap(4),
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: Wrap(
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
                      ),
                      AssetContextMenu(id: asset.id),
                    ],
                  ),
                  if (asset.status == .pendingApproval && isPrivileged) ...[
                    const Gap(8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          final approved = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Approve Asset'),
                              content: const Text('Are you sure you want to approve this asset?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                FilledButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: context.colors.error,
                                    foregroundColor: context.colors.onError,
                                  ),
                                  child: const Text('Approve'),
                                ),
                              ],
                            ),
                          );
                          if (approved == true) {
                            await ref.read(assetDetailsCtrlProvider(asset.id).notifier).approve();
                          }
                        },
                        style: FilledButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text('Approve'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
