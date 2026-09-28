
import 'package:asset_steward_app/features/assets/presentation/screens/tab_views/all_assets_tab_view.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/tab_views/my_assets_tab_view.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/tab_views/pending_assets_tab_view.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/print_labels_sheet.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AssetsPageview extends HookConsumerWidget {
  const AssetsPageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = GoRouterState.of(context);
    final initialTab = int.tryParse(state.uri.queryParameters['tab'] ?? '0') ?? 0;

    return DefaultTabController(
      initialIndex: initialTab,
      length: 3,
      child: Scaffold(
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
                  onTap: () => Toast.showInfo('Asset Report feature coming soon'),
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
        body: const TabBarView(
          children: [
            AllAssetsTabView(),
            PendingAssetsTabView(),
            MyAssetsTabView(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(RPaths.createAsset.path),
          icon: const Icon(HIStroke.plusSign),
          label: const Text('Add Asset'),
        ),
      ),
    );
  }
}
