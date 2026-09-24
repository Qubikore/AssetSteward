import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/features/categories/presentation/controllers/categories_controller.dart';
import 'package:asset_steward_app/features/categories/presentation/screens/create_or_update_category_sheet.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class CategoriesPage extends HookConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(categoriesCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(categoriesCtrlProvider),
        child: AsyncBuilder<List<CategoryModel>>(
          asyncValue: asyncData,
          providers: [categoriesCtrlProvider],
          allowEmpty: true,
          builder: (categories) {
            if (categories.isEmpty) {
              return const EmptyState(
                label: 'No categories',
                subLabel: 'Click the + button to add a new category.',
                icon: Icon(HIStroke.tag01),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(Insets.lg),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const Gap(Insets.md),
              itemBuilder: (context, index) {
                final category = categories[index];
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainerHighest.op(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.colors.outlineVariant.op(0.5)),
                  ),
                  child: Slidable(
                    key: ValueKey(category.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => CreateOrUpdateCategorySheet(category: category),
                            );
                          },
                          backgroundColor: context.colors.primary,
                          foregroundColor: context.colors.onPrimary,
                          icon: HIStroke.pencilEdit02,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (_) {
                            ref.read(categoriesCtrlProvider.notifier).deleteCategory(category.id);
                          },
                          backgroundColor: context.colors.error,
                          foregroundColor: context.colors.onError,
                          icon: HIStroke.delete01,
                          label: 'Delete',
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
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
                            child: Icon(HIStroke.tag01, color: context.colors.primaryContainer),
                          ),
                          const Gap(Insets.md),
                          Expanded(
                            child: Text(
                              category.name,
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
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const CreateOrUpdateCategorySheet(),
          );
        },
        child: const Icon(HIStroke.plusSign),
      ),
    );
  }
}
