import 'package:asset_steward_app/features/assets/presentation/screens/print_labels_sheet.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/stock_report_sheet.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/tab_views/all_assets_tab_view.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/tab_views/my_assets_tab_view.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/tab_views/pending_assets_tab_view.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AssetsPageview extends HookConsumerWidget {
  const AssetsPageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialTab = int.tryParse(context.queryParams['tab'] ?? '0') ?? 0;

    final profile = ref.watch(profileCtrlProvider).value;
    final isPrivileged = profile?.isPrivileged ?? false;
    if (isPrivileged) {
      return DefaultTabController(
        initialIndex: initialTab,
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Assets'),
            actions: [
              ContextMenu(
                alignment: ContextMenuAlignment.end,
                items: [
                  ContextMenuAction(
                    title: 'Print Labels',
                    leading: const Icon(HIStroke.printer),
                    onTap: () => PrintLabelsSheet.show(context),
                  ),
                  ContextMenuAction(
                    title: 'Asset Report',
                    leading: const Icon(HIStroke.documentAttachment),
                    onTap: () => StockReportSheet.show(context),
                  ),
                ],
              ),
              const Gap(8),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Pending'),
                Tab(text: 'Mine'),
              ],
            ),
          ),
          body: const TabBarView(children: [AllAssetsTabView(), PendingAssetsTabView(), MyAssetsTabView()]),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: FloatingActionButton.extended(
              onPressed: () => context.push(RPaths.createAsset.path),
              icon: const Icon(HIStroke.plusSign),
              label: const Text('Add Asset'),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('My Assets'),
        actions: [
          ContextMenu(
            alignment: ContextMenuAlignment.end,
            items: [
              ContextMenuAction(
                title: 'Print Labels',
                leading: const Icon(HIStroke.printer),
                onTap: () => PrintLabelsSheet.show(context),
              ),
              ContextMenuAction(
                title: 'Asset Report',
                leading: const Icon(HIStroke.documentAttachment),
                onTap: () => StockReportSheet.show(context),
              ),
            ],
          ),
          const Gap(8),
        ],
      ),
      body: const MyAssetsTabView(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton.extended(
          onPressed: () => context.push(RPaths.createAsset.path),
          icon: const Icon(HIStroke.plusSign),
          label: const Text('Add Asset'),
        ),
      ),
    );
  }
}
