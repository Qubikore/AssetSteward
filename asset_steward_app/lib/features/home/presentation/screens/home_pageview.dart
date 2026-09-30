import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/asset_list_tile.dart';
import 'package:asset_steward_app/features/locations/presentation/controllers/locations_controller.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/asset_utilization.dart';
import '../../data/models/dashboard_metrics.dart';
import '../controllers/home_controllers.dart';
import 'local_widgets/dashboard_shimmers.dart';
import 'local_widgets/metrics_overview.dart';
import 'local_widgets/utilization_tile.dart';

class HomePageview extends HookConsumerWidget {
  const HomePageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsCtrlProvider);
    final utilizationAsync = ref.watch(assetUtilizationCtrlProvider);
    final pendingAssetsAsync = ref.watch(assetsCtrlProvider(AssetStatus.pendingApproval));
    final profileAsync = ref.watch(profileCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardMetricsCtrlProvider);
          ref.invalidate(assetUtilizationCtrlProvider);
          ref.invalidate(assetsCtrlProvider(AssetStatus.pendingApproval));
          ref.invalidate(locationsCtrlProvider);
        },
        child: ListView(
          physics: kScrollPhysics,
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.lg,
            vertical: Insets.md,
          ).copyWith(top: 6).withBottomEx(),
          children: [
            AsyncBuilder<DashboardMetrics>(
              asyncValue: metricsAsync,
              providers: [dashboardMetricsCtrlProvider],
              onLoading: () => const DashboardMetricsShimmer(),
              builder: (metrics) => MetricsOverview(metrics: metrics),
            ),
            const Gap(Insets.lg),

            Row(
              spacing: Insets.md,
              children: [
                Expanded(child: Text('Asset Utilization', style: context.text.titleMedium?.bold)),
                TextButton(
                  onPressed: () => RPaths.createAsset.push(context),
                  child: Text('+ Add Asset', style: context.text.labelMedium?.textColor(context.colors.primary)),
                ),
              ],
            ),

            AsyncBuilder<List<AssetUtilization>>(
              asyncValue: utilizationAsync,
              providers: [assetUtilizationCtrlProvider],
              allowEmpty: true,
              onLoading: () => const UtilizationShimmer(),
              builder: (utilizations) {
                if (utilizations.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(Insets.lg),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceContainerHighest.op(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.colors.outlineVariant.op(0.3)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: context.colors.secondaryContainer.op1,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(HIStroke.pieChart01, color: context.colors.secondaryContainer, size: 25),
                        ),
                        const Gap(Insets.md),
                        Text('No assets found', style: context.text.titleMedium?.bold),
                        const Gap(Insets.xs),
                        Text(
                          'Add your first asset to see utilization analytics.',
                          style: context.text.bodySmall?.textColor(context.colors.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(Insets.lg),
                        FilledButton.icon(
                          onPressed: () => RPaths.createAsset.push(context),
                          icon: const Icon(HIStroke.plusSign),
                          label: const Text('Add Asset'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: utilizations.length > 5 ? 5 : utilizations.length,
                  separatorBuilder: (context, index) => const Gap(Insets.sm),
                  itemBuilder: (context, index) {
                    final util = utilizations[index];
                    return UtilizationTile(util: util);
                  },
                );
              },
            ),

            if (profileAsync.value?.role != .user) ...[
              const Gap(Insets.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: Insets.md,
                children: [
                  Text('Pending Assets', style: context.text.titleMedium?.bold),
                  TextButton(
                    onPressed: () => context.go('${RPaths.assets.path}?tab=1'),
                    child: Text('Show All', style: context.text.labelMedium?.textColor(context.colors.primary)),
                  ),
                ],
              ),
              AsyncBuilder<List<AssetModel>>(
                asyncValue: pendingAssetsAsync,
                providers: [assetsCtrlProvider(AssetStatus.pendingApproval)],
                allowEmpty: true,
                onLoading: () => const MiniListShimmer(),
                builder: (pendingAssets) {
                  if (pendingAssets.isEmpty) {
                    return Text(
                      'No pending assets.',
                      style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant),
                    );
                  }
                  final list = pendingAssets.take(3).toList();
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) => const Gap(Insets.sm),
                    itemBuilder: (context, index) {
                      return AssetListTile(asset: list[index]);
                    },
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
