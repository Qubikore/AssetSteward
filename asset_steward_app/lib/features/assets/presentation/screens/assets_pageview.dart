import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:screwdriver/screwdriver.dart';

class AssetsPageview extends HookConsumerWidget {
  const AssetsPageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(assetsCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Assets')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(assetsCtrlProvider),
        child: AsyncBuilder<List<AssetModel>>(
          asyncValue: assetsAsync,
          providers: [assetsCtrlProvider],
          allowEmpty: true,
          builder: (assets) {
            if (assets.isEmpty) {
              return const EmptyState(
                label: 'No assets',
                subLabel: 'Click the + button to add a new asset.',
                icon: Icon(HIStroke.laptopProgramming),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.md).copyWith(bottom: 100),
              itemCount: assets.length,
              separatorBuilder: (context, index) => const Gap(Insets.md),
              itemBuilder: (context, index) {
                final asset = assets[index];
                return _AssetListTile(asset: asset);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RPaths.createAsset.path),
        icon: const Icon(HIStroke.plusSign),
        label: const Text('Add Asset'),
      ),
    );
  }
}

class _AssetListTile extends StatelessWidget {
  final AssetModel asset;

  const _AssetListTile({required this.asset});

  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      items: [
        ContextMenuAction(title: 'Edit', leading: const Icon(HIStroke.edit02), onTap: () {}),
        ContextMenuAction(title: 'Delete', isDestructive: true, leading: const Icon(HIStroke.delete02), onTap: () {}),
      ],
      buttonBuilder: (context, open) => GestureDetector(
        onLongPress: open,
        child: Container(
          padding: const EdgeInsets.all(Insets.md),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerHighest.op(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.outlineVariant.op(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: context.colors.primaryContainer.op1, shape: BoxShape.circle),
                child: Icon(HIStroke.laptopProgramming, color: context.colors.primaryContainer),
              ),
              const Gap(Insets.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.name,
                      style: context.text.titleMedium?.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(2),
                    Text(asset.assetCode, style: context.text.bodySmall?.textColor(context.colors.onSurfaceVariant)),
                    const Gap(Insets.md),
                    Row(
                      spacing: Insets.sm,
                      children: [
                        if (asset.categoryName.isNotNullOrBlank)
                          _Badge(icon: HIStroke.tag01, text: asset.categoryName!),
                        if (asset.departmentName.isNotNullOrBlank)
                          _Badge(icon: HIStroke.building02, text: asset.departmentName!),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: asset.status.toLowerCase() == 'available'
                              ? Colors.green.op(0.2)
                              : context.colors.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          asset.status,
                          style: context.text.labelSmall?.bold.textColor(
                            asset.status.toLowerCase() == 'available'
                                ? Colors.green.shade800
                                : context.colors.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(Insets.md),
                  Text('\$${asset.purchasePrice.toStringAsFixed(2)}', style: context.text.titleMedium?.bold),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Badge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: context.colors.onSurfaceVariant),
        const Gap(4),
        Text(text, style: context.text.labelSmall?.textColor(context.colors.onSurfaceVariant)),
      ],
    );
  }
}
