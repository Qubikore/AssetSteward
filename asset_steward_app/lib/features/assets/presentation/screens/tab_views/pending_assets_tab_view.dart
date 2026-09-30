import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/asset_list_tile.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class PendingAssetsTabView extends HookConsumerWidget {
  const PendingAssetsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(assetsCtrlProvider(AssetStatus.pendingApproval));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: InputField(
            hintText: 'Search pending assets...',
            onChanged: (value) {
              ref.read(assetsCtrlProvider(AssetStatus.pendingApproval).notifier).search(value ?? '');
            },
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => ref.read(assetsCtrlProvider(AssetStatus.pendingApproval).notifier).refresh(),
            child: AsyncBuilder(
              asyncValue: assetsAsync,
              providers: [assetsCtrlProvider(AssetStatus.pendingApproval)],
              allowEmpty: true,
              onLoading: () => const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: ShimmerList(count: 8, itemHeight: 80, separatorHeight: Insets.md),
              ),
              builder: (assets) {
                if (assets.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: EmptyState(
                          label: 'No pending assets',
                          subLabel: 'There are no assets waiting for approval.',
                          icon: Icon(HIStroke.checkmarkBadge01),
                        ),
                      ),
                    ],
                  );
                }

                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: Insets.lg)
                      .copyWith(bottom: context.viewInsets.bottom + 16)
                      .withBottomEx(),
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
