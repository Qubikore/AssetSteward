import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/department_model.dart';
import '../controllers/departments_controller.dart';
import 'create_or_update_department_sheet.dart';

class DepartmentsPage extends HookConsumerWidget {
  const DepartmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departmentsAsync = ref.watch(departmentsCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Departments'), centerTitle: true),
      body: AsyncBuilder(
        asyncValue: departmentsAsync,
        allowEmpty: true,
        emptyIcon: const Icon(HIStroke.building04),
        emptyText: 'No departments found.',
        emptySubText: 'Create a new department to get started.',
        providers: [departmentsCtrlProvider],
        builder: (departments) {
          return RefreshIndicator(
            onRefresh: () => ref.refresh(departmentsCtrlProvider.future),
            child: departments.isEmpty
                ? const EmptyState(
                    label: 'No departments found',
                    subLabel: 'Create a new department to get started',
                    icon: Icon(HIStroke.building02),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(Insets.lg),
                    itemCount: departments.length,
                    separatorBuilder: (context, index) => const Gap(Insets.md),
                    itemBuilder: (context, index) {
                      final department = departments[index];
                      return _DepartmentTile(department: department);
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
            builder: (context) => const CreateOrUpdateDepartmentSheet(),
          );
        },
        icon: const Icon(HIStroke.building02),
        label: const Text('New Department'),
      ),
    );
  }
}

class _DepartmentTile extends HookConsumerWidget {
  final DepartmentModel department;

  const _DepartmentTile({required this.department});

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
        key: ValueKey(department.id),
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
                  builder: (context) => CreateOrUpdateDepartmentSheet(department: department),
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
                    title: const Text('Delete Department'),
                    content: Text('Are you sure you want to delete ${department.name}?'),
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
                  final result = await ref.read(departmentsCtrlProvider.notifier).deleteDepartment(department.id);
                  result.fold(
                    (l) => Toast.showError(l.message),
                    (r) => Toast.showSuccess('Department deleted successfully'),
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
                child: Icon(HIStroke.building02, color: context.colors.primaryContainer),
              ),
              const Gap(Insets.md),
              Expanded(
                child: Text(
                  department.name,
                  style: context.text.titleMedium?.bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
