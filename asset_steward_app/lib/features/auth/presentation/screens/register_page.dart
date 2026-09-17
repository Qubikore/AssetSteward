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
    final currentStep = useState(0);

    return Scaffold(
      appBar: AppBar(
        leading: currentStep.value == 1
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => currentStep.value = 0)
            : IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go(RPaths.login.path)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Insets.xl, vertical: Insets.md),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            child: FormBuilder(
              key: formKey,
              // initialValue:
              //     onlyOnDebug({
              //       'organizationName': 'Acme Corp',
              //       'organizationPhone': '1234567890',
              //       'organizationEmail': 'org@acme.com',
              //       'organizationLocation': 'NY',
              //       'firstname': 'Ahnaf',
              //       'lastname': 'Sakil',
              //       'email': 'ahnafsakil9@gmail.com',
              //       'password': 'password123',
              //     }) ??
              //     {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HIStroke.building06, size: 64, color: context.colors.primary),
                  const Gap(Insets.xl),
                  Text(
                    currentStep.value == 0 ? 'Organization Setup' : 'Admin Profile',
                    style: context.text.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.sm),
                  Text(
                    currentStep.value == 0
                        ? 'Step 1 of 2: Let\'s get your organization created.'
                        : 'Step 2 of 2: Set up your primary admin account.',
                    style: context.text.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.xl),

                  // Form Fields
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: currentStep.value == 0
                        ? Column(
                            key: const ValueKey('step0'),
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const InputField(
                                name: 'organizationName',
                                title: 'Organization Name',
                                hintText: 'e.g. Acme Corp',
                                isRequired: true,
                                keyboardType: TextInputType.name,
                              ),
                              const Gap(Insets.md),
                              const InputField(
                                name: 'organizationPhone',
                                title: 'Phone Number',
                                hintText: 'Enter phone number',
                                isRequired: true,
                                keyboardType: TextInputType.phone,
                              ),
                              const Gap(Insets.md),
                              InputField(
                                name: 'organizationEmail',
                                title: 'Business Email',
                                hintText: 'org@company.com',
                                isRequired: true,
                                keyboardType: TextInputType.emailAddress,
                                validators: [FormBuilderValidators.email()],
                              ),
                              const Gap(Insets.md),
                              const InputField(
                                name: 'organizationLocation',
                                title: 'Location / Address (Optional)',
                                hintText: 'City, Country',
                              ),
                            ],
                          )
                        : Column(
                            key: const ValueKey('step1'),
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              const Gap(Insets.md),
                              InputField(
                                name: 'email',
                                title: 'Admin Email',
                                hintText: 'admin@company.com',
                                isRequired: true,
                                keyboardType: TextInputType.emailAddress,
                                validators: [FormBuilderValidators.email()],
                              ),
                              const Gap(Insets.md),
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

                  const Gap(Insets.xl),
                  FilledButton(
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
                  const Gap(Insets.xl),
                  if (currentStep.value == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
