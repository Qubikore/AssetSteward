import 'package:asset_steward_app/features/profile/data/models/profile_data.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

import '../controllers/users_controller.dart';

class CreateUserSheet extends HookConsumerWidget {
  const CreateUserSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final me = ref.watch(profileCtrlProvider).value;

    return SingleChildScrollView(
      padding: EdgeInsets.only(left: Insets.lg, right: Insets.lg, bottom: context.viewInsets.bottom + Insets.xxl),
      child: FormBuilder(
        key: formKey,
        initialValue: const {'role': UserRole.user},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Create New User', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Gap(Insets.xl),
            const Row(
              children: [
                Expanded(
                  child: InputField(name: 'firstname', title: 'First Name', isRequired: true),
                ),
                Gap(Insets.md),
                Expanded(
                  child: InputField(name: 'lastname', title: 'Last Name', isRequired: true),
                ),
              ],
            ),
            const Gap(Insets.md),
            InputField(
              name: 'email',
              title: 'Email Address',
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              validators: [FormBuilderValidators.email()],
            ),
            const Gap(Insets.md),
            InputField(
              name: 'password',
              title: 'Password',
              isRequired: true,
              isPassword: true,
              validators: [FormBuilderValidators.minLength(6)],
            ),
            const Gap(Insets.md),

            Text('Role', style: context.text.labelLarge),
            FormBuilderRadioGroup<UserRole>(
              name: 'role',
              initialValue: .user,
              enabled: me?.role == .superAdmin,
              decoration: const InputDecoration(border: .none, contentPadding: .zero),
              materialTapTargetSize: .shrinkWrap,
              options: UserRole.values.map((role) {
                return FormBuilderFieldOption(value: role, child: Text(role.name.titleCase));
              }).toList(),
              validator: FormBuilderValidators.required(),
            ),
            const Gap(Insets.xl),
            FilledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        isLoading.value = true;
                        final form = formKey.currentState!.value;

                        final role = form['role'] as UserRole;

                        final payload = {
                          'firstname': form['firstname'],
                          'lastname': form['lastname'],
                          'email': form['email'],
                          'password': form['password'],
                          'role': role.name.constantCase,
                        };

                        final result = await ref.read(usersCtrlProvider.notifier).createUser(payload);
                        isLoading.value = false;

                        result.fold((l) => Toast.showError(l.message), (r) {
                          Toast.showSuccess('User created successfully!');
                          context.nPop();
                        });
                      }
                    },
              child: isLoading.value ? const Loader(size: 20, color: Colors.white) : const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
