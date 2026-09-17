import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

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
              initialValue: onlyOnDebug({'email': 'ahnafsakil9@gmail.com', 'password': '123123'}) ?? {},
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
                    name: 'email',
                    title: 'Email',
                    hintText: 'Enter your email',
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
                  FormBuilderCheckbox(
                    name: 'remember_me',
                    title: Text('Remember', style: context.text.bodyMedium),
                    decoration: const InputDecoration(border: InputBorder.none, filled: false),
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  ),
                  const Gap(Insets.lg),
                  FilledButton(
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            final form = formKey.currentState!;
                            if (!form.saveAndValidate()) return;

                            isLoading.value = true;
                            final data = form.value;

                            final result = await authCtrl.login(data);
                            isLoading.value = false;

                            result.fold(
                              (f) => Toast.showError(f.message),
                              (r) => Toast.showSuccess('Logged in successfully'),
                            );
                          },
                    child: isLoading.value ? const Loader(size: 20, color: Colors.white) : const Text('Sign in'),
                  ),
                  const Gap(Insets.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () => context.go(RPaths.register.path),
                        label: const Text('Create Organization'),
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
