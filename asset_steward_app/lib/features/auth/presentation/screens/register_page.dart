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
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: Pads.allXL,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    HIStroke.userAdd01,
                    size: 64,
                    color: context.colors.primary,
                  ),
                  const Gap(Insets.xl),
                  Text(
                    'Create an account',
                    style: context.text.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.sm),
                  Text(
                    'Sign up to get started.',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.xl),
                  const InputField(
                    name: 'name',
                    title: 'Full Name',
                    hintText: 'Enter your full name',
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
                    validators: [
                      FormBuilderValidators.email(),
                    ],
                  ),
                  const Gap(Insets.md),
                  InputField(
                    name: 'password',
                    title: 'Password',
                    hintText: 'Create a password',
                    isRequired: true,
                    isPassword: true,
                    validators: [
                      FormBuilderValidators.minLength(6),
                    ],
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
                        if (val !=
                            formKey.currentState?.fields['password']?.value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      }
                    ],
                  ),
                  const Gap(Insets.xl),
                  FilledButton(
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            if (formKey.currentState?.saveAndValidate() ?? false) {
                              isLoading.value = true;
                              final data = formKey.currentState!.value;
                              
                              final result = await ref
                                  .read(authCtrlProvider.notifier)
                                  .register(data);

                              if (context.mounted) {
                                isLoading.value = false;
                                if (result.isLeft()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          result.getLeft().toNullable()!.message),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                            }
                          },
                    child: isLoading.value
                        ? const Loader(size: 20, color: Colors.white)
                        : const Text('Sign up'),
                  ),
                  const Gap(Insets.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: context.text.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => context.go(RPaths.login.path),
                        child: const Text('Sign in'),
                      ),
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
