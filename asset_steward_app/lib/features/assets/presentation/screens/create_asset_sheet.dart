
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/categories/presentation/controllers/categories_controller.dart';
import 'package:asset_steward_app/features/departments/presentation/controllers/departments_controller.dart';
import 'package:asset_steward_app/features/home/presentation/controllers/home_controllers.dart';
import 'package:asset_steward_app/features/locations/presentation/controllers/locations_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class CreateAssetSheet extends HookConsumerWidget {
  const CreateAssetSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final locationsAsync = ref.watch(locationsCtrlProvider);
    final departmentsAsync = ref.watch(departmentsCtrlProvider);
    final categoriesAsync = ref.watch(categoriesCtrlProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: Insets.lg,
        right: Insets.lg,
        bottom: context.viewInsets.bottom + Insets.xxl,
        top: Insets.lg,
      ),
      child: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add New Asset', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Gap(Insets.xl),

            const InputField(name: 'name', title: 'Asset Name', hintText: 'e.g. MacBook Pro M3', isRequired: true),
            const Gap(Insets.md),

            const Row(
              children: [
                Expanded(
                  child: InputField(name: 'assetCode', title: 'Asset Code', hintText: 'e.g. LPT-001', isRequired: true),
                ),
                Gap(Insets.md),
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
            const Gap(Insets.md),

            Row(
              children: [
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'purchaseDate',
                    decoration: const InputDecoration(labelText: 'Purchase Date'),
                    inputType: InputType.date,
                    format: DateFormat('yyyy-MM-dd'),
                    validator: FormBuilderValidators.required(),
                  ),
                ),
                const Gap(Insets.md),
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'expireDate',
                    decoration: const InputDecoration(labelText: 'Expiry/Warranty Date'),
                    inputType: InputType.date,
                    format: DateFormat('yyyy-MM-dd'),
                    validator: FormBuilderValidators.required(),
                  ),
                ),
              ],
            ),
            const Gap(Insets.md),

            Row(
              children: [
                Expanded(
                  child: InputField(
                    name: 'purchasePrice',
                    title: 'Purchase Price (\$)',
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
                    keyboardType: TextInputType.number,
                    isRequired: true,
                    validators: [FormBuilderValidators.numeric()],
                  ),
                ),
              ],
            ),
            const Gap(Insets.md),

            const InputField(name: 'vendor', title: 'Vendor/Supplier', hintText: 'e.g. Apple Inc.', isRequired: true),
            const Gap(Insets.md),

            FormBuilderDropdown<int>(
              name: 'categoryId',
              decoration: const InputDecoration(labelText: 'Category'),
              validator: FormBuilderValidators.required(),
              items: categoriesAsync.maybeWhen(
                data: (cats) => cats.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                orElse: () => [],
              ),
            ),
            const Gap(Insets.md),

            Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown<int>(
                    name: 'locationId',
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: FormBuilderValidators.required(),
                    items: locationsAsync.maybeWhen(
                      data: (locs) => locs.map((l) => DropdownMenuItem(value: l.id, child: Text(l.name))).toList(),
                      orElse: () => [],
                    ),
                  ),
                ),
                const Gap(Insets.md),
                Expanded(
                  child: FormBuilderDropdown<int>(
                    name: 'departmentId',
                    decoration: const InputDecoration(labelText: 'Department'),
                    validator: FormBuilderValidators.required(),
                    items: departmentsAsync.maybeWhen(
                      data: (deps) => deps.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
                      orElse: () => [],
                    ),
                  ),
                ),
              ],
            ),

            const Gap(Insets.xxl),

            FilledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        isLoading.value = true;
                        final form = formKey.currentState!.value;

                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final purchaseDateStr = formatter.format(form['purchaseDate'] as DateTime);
                        final expireDateStr = formatter.format(form['expireDate'] as DateTime);

                        final payload = {
                          'assetCode': form['assetCode'],
                          'name': form['name'],
                          'serialNumber': form['serialNumber'],
                          'purchaseDate': purchaseDateStr,
                          'expireDate': expireDateStr,
                          'purchasePrice': double.parse(form['purchasePrice'].toString()),
                          'vendor': form['vendor'],
                          'quantity': int.parse(form['quantity'].toString()),
                          'categoryId': form['categoryId'],
                          'locationId': form['locationId'],
                          'departmentId': form['departmentId'],
                        };

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
                      }
                    },
              child: isLoading.value ? const Loader(size: 20, color: Colors.white) : const Text('Create Asset'),
            ),
          ],
        ),
      ),
    );
  }
}
