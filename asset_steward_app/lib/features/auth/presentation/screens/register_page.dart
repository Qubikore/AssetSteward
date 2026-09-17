import 'package:asset_steward_app/main.export.dart';
import 'package:cue/cue.dart';
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
    final currentStep = useState(0);

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: Insets.xl, bottom: Insets.xl, left: Insets.xl, right: Insets.xl),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              child: FormBuilder(
                key: formKey,
                initialValue:
                    onlyOnDebug({
                      'organizationName': 'Acme Corp',
                      'organizationPhone': '1234567890',
                      'organizationEmail': 'org@acme.com',
                      'organizationLocation': 'NY',
                      'firstname': 'Ahnaf',
                      'lastname': 'Sakil',
                      'email': 'ahnafsakil9@gmail.com',
                      'password': 'password123',
                    }) ??
                    {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Step Indicator
                    Row(
                      spacing: Insets.sm,
                      children: [
                        Expanded(
                          child: AnimatedContainer(
                            duration: 300.ms,
                            height: 4,
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),

                        Expanded(
                          child: AnimatedContainer(
                            duration: 300.ms,
                            height: 4,
                            decoration: BoxDecoration(
                              color: currentStep.value >= 1
                                  ? context.colors.primary
                                  : context.colors.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(Insets.xxl),
                    Icon(HIStroke.building06, size: 64, color: context.colors.primary),
                    const Gap(Insets.xl),

                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Cue.onToggle(
                          toggled: currentStep.value == 0,
                          motion: const .spatial(),
                          acts: const [.fadeIn()],
                          child: Column(
                            mainAxisSize: .min,
                            children: [
                              Text('Organization Setup', style: context.text.headlineMedium?.bold, textAlign: .center),
                              const Gap(Insets.sm),
                              Text(
                                'Step 1 of 2: Create your organization',
                                style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant),
                                textAlign: .center,
                              ),
                            ],
                          ),
                        ),
                        Cue.onToggle(
                          toggled: currentStep.value == 1,
                          motion: const Spring.spatial(),
                          acts: const [Act.fadeIn()],
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Admin Profile',
                                style: context.text.headlineMedium?.bold,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(Insets.sm),
                              Text(
                                'Step 2 of 2: Set up your primary admin account.',
                                style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(Insets.xl),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Cue.onToggle(
                          toggled: currentStep.value == 0,
                          motion: const .spatial(),
                          acts: const [
                            .sizedClip(from: NSize(h: 0)),
                            .fadeIn(),
                          ],
                          child: IgnorePointer(
                            ignoring: currentStep.value != 0,
                            child: Column(
                              spacing: Insets.md,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const InputField(
                                  name: 'organizationName',
                                  title: 'Organization Name',
                                  hintText: 'e.g. Acme Corp',
                                  isRequired: true,
                                  keyboardType: TextInputType.name,
                                ),

                                const InputField(
                                  name: 'organizationPhone',
                                  title: 'Phone Number',
                                  hintText: 'Enter phone number',
                                  isRequired: true,
                                  keyboardType: TextInputType.phone,
                                ),

                                InputField(
                                  name: 'organizationEmail',
                                  title: 'Business Email',
                                  hintText: 'org@company.com',
                                  isRequired: true,
                                  keyboardType: TextInputType.emailAddress,
                                  validators: [FormBuilderValidators.email()],
                                ),

                                const InputField(
                                  name: 'organizationLocation',
                                  title: 'Location / Address (Optional)',
                                  hintText: 'City, Country',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Cue.onToggle(
                          toggled: currentStep.value == 1,
                          motion: const .spatial(),
                          acts: const [
                            .sizedClip(from: NSize(h: 0)),
                            .fadeIn(),
                          ],
                          child: IgnorePointer(
                            ignoring: currentStep.value != 1,
                            child: Column(
                              crossAxisAlignment: .stretch,
                              spacing: Insets.md,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        name: 'firstname',
                                        title: 'First Name',
                                        hintText: 'John',
                                        isRequired: true,
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                    Gap(Insets.md),
                                    Expanded(
                                      child: InputField(
                                        name: 'lastname',
                                        title: 'Last Name',
                                        hintText: 'Doe',
                                        isRequired: true,
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                  ],
                                ),

                                InputField(
                                  name: 'email',
                                  title: 'Admin Email',
                                  hintText: 'admin@company.com',
                                  isRequired: true,
                                  keyboardType: TextInputType.emailAddress,
                                  validators: [FormBuilderValidators.email()],
                                ),

                                InputField(
                                  name: 'password',
                                  title: 'Password',
                                  hintText: 'Create a strong password',
                                  isRequired: true,
                                  isPassword: true,
                                  validators: [FormBuilderValidators.minLength(6)],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Gap(Insets.xl),
                    Row(
                      children: [
                        if (currentStep.value == 1) ...[
                          FilledButton(
                            onPressed: isLoading.value ? null : () => currentStep.value = 0,
                            child: const Icon(HIStroke.arrowLeft01),
                          ),
                          const Gap(Insets.md),
                        ],
                        Expanded(
                          child: FilledButton(
                            onPressed: isLoading.value
                                ? null
                                : () async {
                                    final form = formKey.currentState!;
                                    form.save();

                                    if (currentStep.value == 0) {
                                      // Validate Step 1 fields only
                                      final orgNameValid = form.fields['organizationName']?.validate() ?? false;
                                      final orgPhoneValid = form.fields['organizationPhone']?.validate() ?? false;
                                      final orgEmailValid = form.fields['organizationEmail']?.validate() ?? false;

                                      if (orgNameValid && orgPhoneValid && orgEmailValid) {
                                        currentStep.value = 1;
                                      }
                                    } else {
                                      // Validate Step 2 fields only
                                      final fNameValid = form.fields['firstname']?.validate() ?? false;
                                      final lNameValid = form.fields['lastname']?.validate() ?? false;
                                      final emailValid = form.fields['email']?.validate() ?? false;
                                      final passValid = form.fields['password']?.validate() ?? false;

                                      if (fNameValid && lNameValid && emailValid && passValid) {
                                        isLoading.value = true;
                                        final data = QMap.from(form.value);
                                        final result = await authCtrl.registerOrganization(data);
                                        isLoading.value = false;

                                        result.fold(
                                          (f) => Toast.showError(f.message),
                                          (r) => Toast.showSuccess('Organization created successfully!'),
                                        );
                                      }
                                    }
                                  },
                            child: isLoading.value
                                ? const Loader(size: 20, color: Colors.white)
                                : Text(currentStep.value == 0 ? 'Continue' : 'Create Organization'),
                          ),
                        ),
                      ],
                    ),

                    const Gap(Insets.md),
                    if (currentStep.value == 0)
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text('Already have an organization?', style: context.text.bodyMedium),
                          TextButton(onPressed: () => context.go(RPaths.login.path), child: const Text('Sign in')),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
