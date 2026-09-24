import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'asset_list_tile.dart';

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
                return AssetListTile(asset: asset);
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
