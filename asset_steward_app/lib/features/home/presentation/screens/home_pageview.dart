import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/asset_utilization.dart';
import '../../data/models/dashboard_metrics.dart';
import '../controllers/home_controllers.dart';
import 'local_widgets/metrics_overview.dart';
import 'local_widgets/utilization_tile.dart';

class HomePageview extends HookConsumerWidget {
  const HomePageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsCtrlProvider);
    final utilizationAsync = ref.watch(assetUtilizationCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardMetricsCtrlProvider);
          ref.invalidate(assetUtilizationCtrlProvider);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.md).copyWith(top: 6),
          children: [
            AsyncBuilder<DashboardMetrics>(
              asyncValue: metricsAsync,
              providers: [dashboardMetricsCtrlProvider],
              builder: (metrics) => MetricsOverview(metrics: metrics),
            ),
            const Gap(Insets.xl),

            Text('Asset Utilization', style: context.text.titleLarge?.bold),
            const Gap(Insets.md),
            AsyncBuilder<List<AssetUtilization>>(
              asyncValue: utilizationAsync,
              providers: [assetUtilizationCtrlProvider],
              allowEmpty: true,
              builder: (utilizations) {
                if (utilizations.isEmpty) {
                  return const EmptyState(
                    label: 'No data',
                    subLabel: 'No assets found in the system.',
                    icon: Icon(HIStroke.pieChart01),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: utilizations.length,
                  separatorBuilder: (context, index) => const Gap(Insets.md),
                  itemBuilder: (context, index) {
                    final util = utilizations[index];
                    return UtilizationTile(util: util);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
