import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/department_model.dart';
import '../controllers/departments_controller.dart';

class CreateOrUpdateDepartmentSheet extends HookConsumerWidget {
  final DepartmentModel? department;

  const CreateOrUpdateDepartmentSheet({super.key, this.department});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: Insets.lg,
        right: Insets.lg,
        bottom: context.viewInsets.bottom + Insets.xxl,
      ),
      child: FormBuilder(
        key: formKey,
        initialValue: {
          'name': department?.name,
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(Insets.md),
            Text(
              department == null ? 'New Department' : 'Edit Department',
              style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Gap(Insets.xl),
            const InputField(
              name: 'name',
              title: 'Name',
              hintText: 'Enter department name',
              isRequired: true,
              keyboardType: TextInputType.name,
            ),
            const Gap(Insets.xxl),
            FilledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        isLoading.value = true;
                        final form = formKey.currentState!.value;

                        final data = {
                          'name': form['name'],
                        };

                        try {
                          if (department == null) {
                            final result = await ref.read(departmentsCtrlProvider.notifier).createDepartment(data);
                            result.fold((l) => Toast.showError(l.message), (r) {
                              Toast.showSuccess('Department created successfully');
                              if (context.mounted) context.nPop();
                            });
                          } else {
                            final result = await ref.read(departmentsCtrlProvider.notifier).updateDepartment(department!.id, data);
                            result.fold((l) => Toast.showError(l.message), (r) {
                              Toast.showSuccess('Department updated successfully');
                              if (context.mounted) context.nPop();
                            });
                          }
                        } finally {
                          isLoading.value = false;
                        }
                      }
                    },
              child: isLoading.value
                  ? const Loader(size: 20, color: Colors.white)
                  : Text(department == null ? 'Create Department' : 'Update Department'),
            ),
          ],
        ),
      ),
    );
  }
}
