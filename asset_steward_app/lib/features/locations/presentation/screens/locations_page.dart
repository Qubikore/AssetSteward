import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:screwdriver/screwdriver.dart';

import '../../data/models/location_model.dart';
import '../controllers/locations_controller.dart';
import 'create_or_update_location_sheet.dart';

class LocationsPage extends HookConsumerWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationsCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Locations'), centerTitle: true),
      body: AsyncBuilder(
        asyncValue: locationsAsync,
        allowEmpty: true,
        providers: [locationsCtrlProvider],
        builder: (locations) {
          return RefreshIndicator(
            onRefresh: () => ref.refresh(locationsCtrlProvider.future),
            child: locations.isEmpty
                ? const EmptyState(
                    label: 'No locations found',
                    subLabel: 'Create a new location to get started',
                    icon: Icon(HIStroke.location01),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(Insets.lg),
                    itemCount: locations.length,
                    separatorBuilder: (context, index) => const Gap(Insets.md),
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return _LocationTile(location: location);
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            showDragHandle: true,
            builder: (context) => const CreateOrUpdateLocationSheet(),
          );
        },
        icon: const Icon(HIStroke.location01),
        label: const Text('New Location'),
      ),
    );
  }
}

class _LocationTile extends HookConsumerWidget {
  final LocationModel location;

  const _LocationTile({required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      child: Slidable(
        key: ValueKey(location.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  builder: (context) => CreateOrUpdateLocationSheet(location: location),
                );
              },
              backgroundColor: context.colors.primaryContainer,
              foregroundColor: context.colors.onPrimaryContainer,
              icon: HIStroke.edit03,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Location'),
                    content: Text('Are you sure you want to delete ${location.name}?'),
                    actions: [
                      TextButton(onPressed: () => context.nPop(false), child: const Text('Cancel')),
                      FilledButton(
                        onPressed: () => context.nPop(true),
                        style: FilledButton.styleFrom(
                          backgroundColor: context.colors.error,
                          foregroundColor: context.colors.onError,
                        ),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final result = await ref.read(locationsCtrlProvider.notifier).deleteLocation(location.id);
                  result.fold(
                    (l) => Toast.showError(l.message),
                    (r) => Toast.showSuccess('Location deleted successfully'),
                  );
                }
              },
              backgroundColor: context.colors.error,
              foregroundColor: context.colors.onError,
              icon: HIStroke.delete01,
              label: 'Delete',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(Insets.md),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: context.colors.primaryContainer.op2,
                child: Icon(HIStroke.location01, color: context.colors.primaryContainer),
              ),
              const Gap(Insets.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      location.name,
                      style: context.text.titleMedium?.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (location.address.isNotNullOrBlank)
                      Text(
                        location.address!,
                        style: context.text.bodySmall?.textColor(context.colors.onSurfaceVariant),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
