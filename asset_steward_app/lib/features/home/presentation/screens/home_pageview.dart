import 'package:asset_steward_app/features/departments/data/models/department_model.dart';
import 'package:asset_steward_app/features/departments/presentation/controllers/departments_controller.dart';
import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:asset_steward_app/features/locations/presentation/controllers/locations_controller.dart';
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
    final departmentsAsync = ref.watch(departmentsCtrlProvider);
    final locationsAsync = ref.watch(locationsCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardMetricsCtrlProvider);
          ref.invalidate(assetUtilizationCtrlProvider);
          ref.invalidate(departmentsCtrlProvider);
          ref.invalidate(locationsCtrlProvider);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.lg,
            vertical: Insets.md,
          ).copyWith(top: 6, bottom: Insets.xxl),
          children: [
            AsyncBuilder<DashboardMetrics>(
              asyncValue: metricsAsync,
              providers: [dashboardMetricsCtrlProvider],
              onLoading: () => const DashboardMetricsShimmer(),
              builder: (metrics) => MetricsOverview(metrics: metrics),
            ),
            const Gap(Insets.lg),

            Text('Asset Utilization', style: context.text.titleMedium?.bold),
            const Gap(Insets.md),
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
                          onPressed: () {
                            Toast.showError('Not implemented yet');
                          },
                          icon: const Icon(HIStroke.plusSign),
                          label: const Text('Add Asset'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
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

            const Gap(Insets.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Departments', style: context.text.titleMedium?.bold),
                TextButton(onPressed: () => context.push(RPaths.departments.path), child: const Text('View All')),
              ],
            ),
            AsyncBuilder<List<DepartmentModel>>(
              asyncValue: departmentsAsync,
              providers: [departmentsCtrlProvider],
              allowEmpty: true,
              onLoading: () => const MiniListShimmer(),
              builder: (departments) {
                if (departments.isEmpty) {
                  return Text(
                    'No departments configured.',
                    style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant),
                  );
                }
                final list = departments.take(2).toList();
                return Column(
                  children: list
                      .map(
                        (d) => Padding(
                          padding: const EdgeInsets.only(bottom: Insets.sm),
                          child: _MiniEntityTile(title: d.name, icon: HIStroke.building02),
                        ),
                      )
                      .toList(),
                );
              },
            ),

            // const Gap(Insets.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Locations', style: context.text.titleMedium?.bold),
                TextButton(onPressed: () => context.push(RPaths.locations.path), child: const Text('View All')),
              ],
            ),
            AsyncBuilder<List<LocationModel>>(
              asyncValue: locationsAsync,
              providers: [locationsCtrlProvider],
              allowEmpty: true,
              onLoading: () => const MiniListShimmer(),
              builder: (locations) {
                if (locations.isEmpty) {
                  return Text(
                    'No locations configured.',
                    style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant),
                  );
                }
                final list = locations.take(2).toList();
                return Column(
                  children: list
                      .map(
                        (l) => Padding(
                          padding: const EdgeInsets.only(bottom: Insets.sm),
                          child: _MiniEntityTile(title: l.name, subtitle: l.address, icon: HIStroke.location01),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniEntityTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const _MiniEntityTile({required this.title, this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outlineVariant.op(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: context.colors.primaryContainer, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: context.colors.onPrimaryContainer, size: 20),
          ),
          const Gap(Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.text.bodyMedium?.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const Gap(2),
                  Text(
                    subtitle!,
                    style: context.text.bodySmall?.textColor(context.colors.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
