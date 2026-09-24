import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/features/categories/presentation/controllers/categories_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class CreateOrUpdateCategorySheet extends HookConsumerWidget {
  final CategoryModel? category;

  const CreateOrUpdateCategorySheet({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final isEdit = category != null;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: Insets.lg,
        right: Insets.lg,
        bottom: context.viewInsets.bottom + Insets.xxl,
        top: Insets.lg,
      ),
      child: FormBuilder(
        key: formKey,
        initialValue: {
          if (isEdit) 'name': category!.name,
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEdit ? 'Update Category' : 'Add New Category',
              style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(Insets.xl),
            const InputField(
              name: 'name',
              title: 'Category Name',
              hintText: 'e.g. Laptops',
              isRequired: true,
            ),
            const Gap(Insets.xxl),
            FilledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        isLoading.value = true;
                        final form = formKey.currentState!.value;

                        final payload = {
                          'name': form['name'],
                        };

                        final success = isEdit
                            ? await ref.read(categoriesCtrlProvider.notifier).updateCategory(category!.id, payload)
                            : await ref.read(categoriesCtrlProvider.notifier).createCategory(payload);

                        isLoading.value = false;

                        if (success) {
                          Toast.showSuccess(isEdit ? 'Category updated successfully!' : 'Category created successfully!');
                          context.nPop();
                        }
                      }
                    },
              child: isLoading.value
                  ? const Loader(size: 20, color: Colors.white)
                  : Text(isEdit ? 'Update Category' : 'Create Category'),
            ),
          ],
        ),
      ),
    );
  }
}
