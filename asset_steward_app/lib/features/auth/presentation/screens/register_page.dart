import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../controllers/auth_controller.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: Pads.allXL,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: FormBuilder(
              key: formKey,
              initialValue:
                  onlyOnDebug({
                    'firstname': 'Ahnaf',
                    'lastname': 'Sakil',
                    'email': 'ahnafsakil9@gmail.com',
                    'password': '123123',
                    'confirm_password': '123123',
                  }) ??
                  {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HIStroke.userAdd01, size: 64, color: context.colors.primary),
                  const Gap(Insets.xl),
                  Text(
                    'Create an account',
                    style: context.text.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.sm),
                  Text(
                    'Sign up to get started.',
                    style: context.text.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.xl),
                  const InputField(
                    name: 'firstname',
                    title: 'First Name',
                    hintText: 'Enter your first name',
                    isRequired: true,
                    keyboardType: TextInputType.name,
                  ),
                  const Gap(Insets.md),
                  const InputField(
                    name: 'lastname',
                    title: 'Last Name',
                    hintText: 'Enter your last name',
                    isRequired: true,
                    keyboardType: TextInputType.name,
                  ),
                  const Gap(Insets.md),
                  InputField(
                    name: 'email',
                    title: 'Email',
                    hintText: 'Enter your email',
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                    validators: [FormBuilderValidators.email()],
                  ),
                  const Gap(Insets.md),
                  InputField(
                    name: 'password',
                    title: 'Password',
                    hintText: 'Create a password',
                    isRequired: true,
                    isPassword: true,
                    validators: [FormBuilderValidators.minLength(6)],
                  ),
                  const Gap(Insets.md),
                  InputField(
                    name: 'confirm_password',
                    title: 'Confirm Password',
                    hintText: 'Repeat your password',
                    isRequired: true,
                    isPassword: true,
                    validators: [
                      (val) {
                        if (val != formKey.currentState?.fields['password']?.value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ],
                  ),
                  const Gap(Insets.xl),
                  FilledButton(
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            final form = formKey.currentState!;
                            if (!form.saveAndValidate()) return;

                            isLoading.value = true;
                            final data = QMap.from(form.value);
                            data.remove('confirm_password');
                            data.addAll({'role': 'SUPER_ADMIN'});

                            final result = await authCtrl.register(data);
                            isLoading.value = false;

                            result.fold(
                              (f) => Toast.showError(f.message),
                              (r) => Toast.showSuccess('Logged in successfully'),
                            );
                          },
                    child: isLoading.value ? const Loader(size: 20, color: Colors.white) : const Text('Sign up'),
                  ),
                  const Gap(Insets.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: context.text.bodyMedium),
                      TextButton(onPressed: () => context.go(RPaths.login.path), child: const Text('Sign in')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
