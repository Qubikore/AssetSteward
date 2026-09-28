import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/asset_list_tile.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class MyAssetsTabView extends HookConsumerWidget {
  const MyAssetsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(myAssetsCtrlProvider);

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => ref.read(myAssetsCtrlProvider.notifier).refresh(),
            child: AsyncBuilder(
              asyncValue: assignmentsAsync,
              providers: [myAssetsCtrlProvider],
              allowEmpty: true,
              builder: (assignments) {
                if (assignments.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: EmptyState(
                          label: 'No assets assigned to you',
                          subLabel: 'You currently have no active asset assignments.',
                          icon: Icon(HIStroke.userCircle),
                        ),
                      ),
                    ],
                  );
                }

                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: Insets.lg)
                      .copyWith(bottom: context.viewInsets.bottom)
                      .withBottomEx(),
                  itemCount: assignments.length,
                  separatorBuilder: (context, index) => const Gap(Insets.md),
                  itemBuilder: (context, index) {
                    final assignment = assignments[index];
                    if (assignment.asset == null) return const SizedBox.shrink();
                    return AssetListTile(asset: assignment.asset!);
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
