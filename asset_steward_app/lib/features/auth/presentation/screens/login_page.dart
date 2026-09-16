import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HIStroke.briefcase02, size: 64, color: context.colors.primary),
                  const Gap(Insets.xl),
                  Text(
                    'Welcome back',
                    style: context.text.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.sm),
                  Text(
                    'Please enter your details to sign in.',
                    style: context.text.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.xl),
                  const InputField(
                    name: 'username',
                    title: 'Username / Email',
                    hintText: 'Enter your username or email',
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(Insets.md),
                  const InputField(
                    name: 'password',
                    title: 'Password',
                    hintText: 'Enter your password',
                    isRequired: true,
                    isPassword: true,
                  ),
                  const Gap(Insets.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FormBuilderCheckbox(
                          name: 'remember_me',
                          title: Text('Remember for 30 days', style: context.text.bodyMedium),
                          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                        ),
                      ),
                    ],
                  ),
                  const Gap(Insets.lg),
                  FilledButton(
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            if (formKey.currentState?.saveAndValidate() ?? false) {
                              isLoading.value = true;
                              final data = formKey.currentState!.value;

                              final result = await ref.read(authCtrlProvider.notifier).login(data);

                              if (context.mounted) {
                                isLoading.value = false;
                                if (result.isLeft()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result.getLeft().toNullable()!.message),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                            }
                          },
                    child: isLoading.value ? const Loader(size: 20, color: Colors.white) : const Text('Sign in'),
                  ),
                  const Gap(Insets.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?', style: context.text.bodyMedium),
                      TextButton(onPressed: () => context.go(RPaths.register.path), child: const Text('Sign up')),
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
