import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/maintenance/presentation/controllers/maintenance_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class StartMaintenanceSheet extends HookConsumerWidget {
  final int? assetId;

  const StartMaintenanceSheet({super.key, this.assetId});

  static Future<bool?> show(BuildContext context, {int? assetId}) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (context) => StartMaintenanceSheet(assetId: assetId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final assetsAsync = ref.watch(assetsCtrlProvider);

    void onSubmit() async {
      final state = formKey.currentState!;
      if (!state.saveAndValidate()) return;

      isLoading.value = true;
      final data = formKey.currentState!.value;

      final notifier = ref.read(maintenanceCtrlProvider.notifier);
      final isOk = await notifier.startMaintenance(data);
      isLoading.value = false;

      if (context.mounted && isOk) {
        context.pop(true);
      }
    }

    return GestureDetector(
      onTap: () => InputUtils.unFocus(),
      child: Padding(
        padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0).copyWith(top: 0),
            child: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Start Maintenance', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const Gap(24),
                  if (assetId == null) ...[
                    AsyncBuilder(
                      asyncValue: assetsAsync,
                      allowEmpty: true,
                      onLoading: () => AutocompleteBox.loading('Asset'),
                      builder: (assets) {
                        return AutocompleteFormBox<AssetModel>(
                          name: 'assetId',
                          label: 'Asset',
                          placeholder: 'Search and select an asset...',
                          items: assets,
                          itemLabel: (a) => a.name,
                          validator: FormBuilderValidators.required(errorText: 'Please select an asset'),
                          valueTransformer: (x) => x?.id.toString(),
                        );
                      },
                    ),
                    const Gap(16),
                  ],
                  const InputField(
                    name: 'description',
                    title: 'Description',
                    hintText: 'Enter maintenance description',
                    isRequired: true,
                    maxLines: 2,
                  ),
                  const Gap(16),
                  const InputField(
                    name: 'cost',
                    title: 'Cost',
                    hintText: 'Enter estimated or actual cost',
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(16),
                  const InputField(
                    name: 'provider',
                    title: 'Provider',
                    hintText: 'Enter service provider name',
                    // isRequired: true,
                  ),
                  const Gap(24),
                  FormBuilderDateTimePicker(
                    name: 'startDate',
                    inputType: InputType.date,
                    decoration: const InputDecoration(labelText: 'Start Date', border: OutlineInputBorder()),
                    initialValue: DateTime.now(),
                    validator: FormBuilderValidators.required(errorText: 'Please select a start date'),
                    valueTransformer: (x) => x?.formatDate('yyyy-MM-dd'),
                  ),
                  const Gap(32),
                  FilledButton(
                    onPressed: isLoading.value ? null : onSubmit,
                    child: isLoading.value
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Submit'),
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
