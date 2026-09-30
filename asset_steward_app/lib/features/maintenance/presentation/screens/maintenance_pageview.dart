import 'package:asset_steward_app/features/maintenance/presentation/controllers/maintenance_controller.dart';
import 'package:asset_steward_app/features/maintenance/presentation/screens/start_maintenance_sheet.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'maintenance_tile.dart';

class MaintenancePageview extends HookConsumerWidget {
  const MaintenancePageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maintenanceAsync = ref.watch(maintenanceCtrlProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Maintenance'), centerTitle: true),
        floatingActionButton: FloatingActionButton(
          onPressed: () => StartMaintenanceSheet.show(context),
          child: const Icon(HIStroke.add01),
        ),
        body: RefreshIndicator(
          onRefresh: () async => ref.read(maintenanceCtrlProvider.notifier).refresh(),
          child: AsyncBuilder(
            asyncValue: maintenanceAsync,
            providers: [maintenanceCtrlProvider],
            onLoading: () => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ShimmerList(count: 6, itemHeight: 100, separatorHeight: 12),
            ),
            onEmpty: () => const EmptyState(
              label: 'No Maintenance Records',
              subLabel: 'There are no active or completed maintenance records.',
              icon: Icon(HIStroke.repair),
            ),
            builder: (maintenanceList) {
              return ListView.separated(
                physics: kScrollPhysics,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: maintenanceList.length,
                separatorBuilder: (_, _) => const Gap(12),
                itemBuilder: (context, index) {
                  final record = maintenanceList[index];
                  return MaintenanceTile(record: record);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
