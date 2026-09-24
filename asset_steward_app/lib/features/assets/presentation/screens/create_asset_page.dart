import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/features/categories/presentation/controllers/categories_controller.dart';
import 'package:asset_steward_app/features/departments/data/models/department_model.dart';
import 'package:asset_steward_app/features/departments/presentation/controllers/departments_controller.dart';
import 'package:asset_steward_app/features/home/presentation/controllers/home_controllers.dart';
import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:asset_steward_app/features/locations/presentation/controllers/locations_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class CreateAssetPage extends HookConsumerWidget {
  const CreateAssetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final locationsAsync = ref.watch(locationsCtrlProvider);
    final departmentsAsync = ref.watch(departmentsCtrlProvider);
    final categoriesAsync = ref.watch(categoriesCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Asset'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.lg,
        ).copyWith(bottom: context.viewInsets.bottom + Insets.xxl),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Section(
                title: 'General Information',
                icon: HIStroke.laptopProgramming,
                children: [
                  InputField(name: 'name', title: 'Asset Name', hintText: 'e.g. MacBook Pro M3', isRequired: true),
                  Gap(Insets.md),
                  Row(
                    spacing: Insets.md,
                    children: [
                      Expanded(
                        child: InputField(
                          name: 'assetCode',
                          title: 'Asset Code',
                          hintText: 'e.g. LPT-001',
                          isRequired: true,
                        ),
                      ),

                      Expanded(
                        child: InputField(
                          name: 'serialNumber',
                          title: 'Serial Number',
                          hintText: 'e.g. C02X...',
                          isRequired: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(Insets.xl),

              _Section(
                title: 'Purchase Details',
                icon: HIStroke.money01,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          name: 'purchasePrice',
                          title: 'Purchase Price (\$)',
                          hintText: 'e.g. 100.00',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          isRequired: true,
                          validators: [FormBuilderValidators.numeric()],
                        ),
                      ),
                      const Gap(Insets.md),
                      Expanded(
                        child: InputField(
                          name: 'quantity',
                          title: 'Quantity',
                          hintText: 'e.g. 10',
                          keyboardType: TextInputType.number,
                          isRequired: true,
                          validators: [FormBuilderValidators.numeric()],
                        ),
                      ),
                    ],
                  ),
                  const Gap(Insets.md),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Purchase Date', style: context.text.titleSmall?.medium).required(),
                            const Gap(Insets.xs),

                            FormBuilderDateTimePicker(
                              name: 'purchaseDate',
                              decoration: const InputDecoration(hintText: 'yyyy-MM-dd'),
                              inputType: InputType.date,
                              format: DateFormat('yyyy-MM-dd'),
                              validator: FormBuilderValidators.required(),
                              valueTransformer: (x) => x?.formatDate('yyyy-MM-dd'),
                            ),
                          ],
                        ),
                      ),
                      const Gap(Insets.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expiry/Warranty Date', style: context.text.titleSmall?.medium),
                            FormBuilderDateTimePicker(
                              name: 'expireDate',
                              decoration: const InputDecoration(hintText: 'yyyy-MM-dd'),
                              inputType: InputType.date,
                              format: DateFormat('yyyy-MM-dd'),
                              validator: FormBuilderValidators.required(),
                              valueTransformer: (x) => x?.formatDate('yyyy-MM-dd'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Gap(Insets.md),
                  const InputField(
                    name: 'vendor',
                    title: 'Vendor/Supplier',
                    hintText: 'e.g. Apple Inc.',
                    isRequired: true,
                  ),
                ],
              ),
              const Gap(Insets.xl),

              _Section(
                title: 'Categorization & Location',
                icon: HIStroke.tag01,
                children: [
                  AutocompleteFormBox<CategoryModel>(
                    name: 'category',
                    label: 'Category',
                    placeholder: 'Select a category...',
                    validator: FormBuilderValidators.required(),
                    isRequired: true,
                    items: categoriesAsync.maybeWhen(data: (cats) => cats, orElse: () => []),
                    itemLabel: (c) => c.name,
                    valueTransformer: (x) => x?.id,
                  ),
                  const Gap(Insets.md),
                  Row(
                    spacing: Insets.md,
                    children: [
                      Expanded(
                        child: AutocompleteFormBox<LocationModel>(
                          name: 'location',
                          label: 'Location',
                          placeholder: 'Select a location...',
                          validator: FormBuilderValidators.required(),
                          isRequired: true,
                          items: locationsAsync.maybeWhen(data: (locs) => locs, orElse: () => []),
                          itemLabel: (l) => l.name,
                          valueTransformer: (x) => x?.id,
                        ),
                      ),
                      Expanded(
                        child: AutocompleteFormBox<DepartmentModel>(
                          name: 'department',
                          label: 'Department',
                          placeholder: 'Select a department...',
                          validator: FormBuilderValidators.required(),
                          isRequired: true,
                          items: departmentsAsync.maybeWhen(data: (deps) => deps, orElse: () => []),
                          itemLabel: (d) => d.name,
                          valueTransformer: (x) => x?.id,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Gap(Insets.xxl),

              FilledButton(
                onPressed: isLoading.value
                    ? null
                    : () async {
                        final state = formKey.currentState!;

                        if (!state.saveAndValidate()) return;

                        isLoading.value = true;
                        final payload = state.value;

                        final success = await ref.read(assetsCtrlProvider.notifier).createAsset(payload);
                        isLoading.value = false;

                        if (success) {
                          Toast.showSuccess('Asset created successfully!');
                          if (context.mounted) context.nPop();

                          ref.invalidate(dashboardMetricsCtrlProvider);
                          ref.invalidate(assetUtilizationCtrlProvider);
                        } else {
                          Toast.showError('Failed to create asset');
                        }
                      },
                child: isLoading.value ? const Loader(size: 20, color: Colors.white) : const Text('Create Asset'),
              ),

              const Gap(Insets.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _Section({required this.title, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: context.colors.onPrimaryContainer, size: 20),
              ),
              const Gap(Insets.md),
              Text(title, style: context.text.titleMedium?.bold),
            ],
          ),
          const Gap(Insets.lg),
          ...children,
        ],
      ),
    );
  }
}
