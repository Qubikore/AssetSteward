import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/features/categories/presentation/controllers/categories_controller.dart';
import 'package:asset_steward_app/features/categories/presentation/screens/create_or_update_category_sheet.dart';
import 'package:asset_steward_app/features/departments/data/models/department_model.dart';
import 'package:asset_steward_app/features/departments/presentation/controllers/departments_controller.dart';
import 'package:asset_steward_app/features/departments/presentation/screens/create_or_update_department_sheet.dart';
import 'package:asset_steward_app/features/home/presentation/controllers/home_controllers.dart';
import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:asset_steward_app/features/locations/presentation/controllers/locations_controller.dart';
import 'package:asset_steward_app/features/locations/presentation/screens/create_or_update_location_sheet.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:screwdriver/screwdriver.dart';

class CreateAssetPage extends HookConsumerWidget {
  final AssetModel? asset;

  const CreateAssetPage({super.key, this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final locationsAsync = ref.watch(locationsCtrlProvider);
    final departmentsAsync = ref.watch(departmentsCtrlProvider);
    final categoriesAsync = ref.watch(categoriesCtrlProvider);

    final profile = ref.watch(profileCtrlProvider).value;
    final isPrivileged = profile?.isPrivileged ?? false;

    return GestureDetector(
      onTap: () => InputUtils.unFocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(asset == null ? 'Add New Asset' : 'Edit Asset'), centerTitle: true),
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
                _Section(
                  title: 'General Information',
                  icon: HIStroke.laptopProgramming,
                  children: [
                    InputField(
                      name: 'name',
                      title: 'Asset Name',
                      hintText: 'e.g. MacBook Pro M3',
                      initialValue: asset?.name,
                      isRequired: true,
                    ),
                    const Gap(Insets.md),
                    InputField(
                      name: 'serialNumber',
                      title: 'Serial Number',
                      hintText: 'e.g. C02X...',
                      initialValue: asset?.serialNumber,
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
                            title: 'Purchase Price',
                            hintText: 'e.g. 100.00',
                            initialValue: asset?.purchasePrice.toString(),
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
                            // initialValue: (asset?.quantity ?? 1).toString(),
                            keyboardType: TextInputType.number,
                            // isRequired: true,
                            validators: [FormBuilderValidators.numeric(checkNullOrEmpty: false)],
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
                                initialValue: DateTime.tryParse(asset?.purchaseDate ?? ' ') ?? DateTime.now(),
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
                                initialValue: DateTime.tryParse(asset?.expireDate ?? ' '),
                                decoration: const InputDecoration(hintText: 'yyyy-MM-dd'),
                                inputType: InputType.date,
                                format: DateFormat('yyyy-MM-dd'),

                                valueTransformer: (x) => x?.formatDate('yyyy-MM-dd'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const Gap(Insets.md),
                    const InputField(name: 'vendor', title: 'Vendor/Supplier', hintText: 'e.g. Apple Inc.'),
                  ],
                ),
                const Gap(Insets.xl),

                _Section(
                  title: 'Categorization & Location',
                  icon: HIStroke.tag01,
                  children: [
                    AsyncBuilder(
                      asyncValue: categoriesAsync,
                      allowEmpty: true,
                      onLoading: () => AutocompleteBox.loading('Category'),
                      builder: (categories) {
                        final category = categories.firstWhereOrNull((c) => c.id == asset?.category?.id);
                        return AutocompleteFormBox<CategoryModel>(
                          name: 'categoryId',
                          label: 'Category',
                          placeholder: 'Select a category...',
                          initialValue: category,
                          items: categories,
                          itemLabel: (c) => c.name,
                          valueTransformer: (x) => x?.id,
                          labelAction: !isPrivileged
                              ? null
                              : Text(
                                  '+ Add Category',
                                  style: context.text.labelMedium?.textColor(context.colors.primary),
                                ).clickable(onTap: () => CreateOrUpdateCategorySheet.show(context, null)),
                        );
                      },
                    ),
                    const Gap(Insets.md),
                    AsyncBuilder(
                      asyncValue: locationsAsync,
                      allowEmpty: true,
                      onLoading: () => AutocompleteBox.loading('Location'),
                      builder: (locations) {
                        final location = locations.firstWhereOrNull((c) => c.id == asset?.location?.id);
                        return AutocompleteFormBox<LocationModel>(
                          name: 'locationId',
                          label: 'Location',
                          placeholder: 'Select a location...',
                          initialValue: location,
                          items: locations,
                          itemLabel: (l) => l.name,
                          valueTransformer: (x) => x?.id,
                          labelAction: !isPrivileged
                              ? null
                              : Text(
                                  '+ Add Location',
                                  style: context.text.labelMedium?.textColor(context.colors.primary),
                                ).clickable(onTap: () => CreateOrUpdateLocationSheet.show(context, null)),
                        );
                      },
                    ),
                    const Gap(Insets.md),
                    AsyncBuilder(
                      asyncValue: departmentsAsync,
                      allowEmpty: true,
                      onLoading: () => AutocompleteBox.loading('Location'),
                      builder: (departments) {
                        final department = departments.firstWhereOrNull((c) => c.id == asset?.department?.id);
                        return AutocompleteFormBox<DepartmentModel>(
                          name: 'departmentId',
                          label: 'Department',
                          placeholder: 'Select a department...',
                          initialValue: department,

                          items: departments,
                          itemLabel: (d) => d.name,
                          valueTransformer: (x) => x?.id,
                          labelAction: !isPrivileged
                              ? null
                              : Text(
                                  '+ Add Department',
                                  style: context.text.labelMedium?.textColor(context.colors.primary),
                                ).clickable(onTap: () => CreateOrUpdateDepartmentSheet.show(context, null)),
                        );
                      },
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

                          final bool success;
                          if (asset != null) {
                            success = await ref.read(assetDetailsCtrlProvider(asset!.id).notifier).updateAsset(payload);
                          } else {
                            success = await ref.read(assetsCtrlProvider().notifier).createAsset(payload);
                          }

                          isLoading.value = false;

                          if (success) {
                            Toast.showSuccess(
                              asset != null ? 'Asset updated successfully!' : 'Asset created successfully!',
                            );
                            if (context.mounted) context.nPop();

                            ref.invalidate(dashboardMetricsCtrlProvider);
                            ref.invalidate(assetUtilizationCtrlProvider);
                          } else {
                            Toast.showError(asset != null ? 'Failed to update asset' : 'Failed to create asset');
                          }
                        },
                  child: isLoading.value
                      ? const Loader(size: 20, color: Colors.white)
                      : Text(asset != null ? 'Save Changes' : 'Create Asset'),
                ),

                const Gap(Insets.xxl),
              ],
            ),
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
              Icon(icon, color: context.colors.primary, size: 18),
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
