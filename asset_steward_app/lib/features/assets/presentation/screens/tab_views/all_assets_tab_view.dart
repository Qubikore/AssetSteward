import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/asset_list_tile.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';

class AllAssetsTabView extends HookConsumerWidget {
  const AllAssetsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(assetsCtrlProvider(null));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: InputField(
            hintText: 'Search all assets...',
            onChanged: (value) {
              ref.read(assetsCtrlProvider(null).notifier).search(value ?? '');
            },
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => ref.read(assetsCtrlProvider(null).notifier).refresh(),
            child: AsyncBuilder<List<AssetModel>>(
              asyncValue: assetsAsync,
              providers: [assetsCtrlProvider(null)],
              allowEmpty: true,
              builder: (assets) {
                if (assets.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: EmptyState(
                          label: 'No assets found',
                          subLabel: 'Try adjusting your search or add a new asset.',
                          icon: Icon(HIStroke.laptopProgramming),
                        ),
                      ),
                    ],
                  );
                }

                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: Insets.lg).withBottomEx(),
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
        ),
      ],
    );
  }
}
