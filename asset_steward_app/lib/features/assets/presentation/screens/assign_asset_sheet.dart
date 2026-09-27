import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:asset_steward_app/features/locations/presentation/controllers/locations_controller.dart';
import 'package:asset_steward_app/features/profile/data/models/profile_data.dart';
import 'package:asset_steward_app/features/users/presentation/controllers/users_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AssignAssetSheet extends HookConsumerWidget {
  final AssetModel asset;

  const AssignAssetSheet({super.key, required this.asset});

  static Future<bool?> show(BuildContext context, AssetModel asset) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => AssignAssetSheet(asset: asset),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final usersAsync = ref.watch(usersCtrlProvider);
    final locationsAsync = ref.watch(locationsCtrlProvider);

    void onSubmit() async {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        isLoading.value = true;

        final data = formKey.currentState!.value;
        final userId = (data['userId'] as ProfileData).id;
        final locationId = (data['locationId'] as LocationModel?)?.id;

        final payload = {'assetId': asset.id, 'userId': userId};

        if (locationId != null) {
          payload['locationId'] = locationId;
        }

        final success = await ref.read(assetsCtrlProvider.notifier).assignAsset(payload);
        if (success && context.mounted) {
          context.pop(true);
        } else {
          isLoading.value = false;
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FormBuilder(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Assign Asset', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const Gap(8),
                Text(
                  'You are assigning ${asset.name}${asset.serialNumber != null ? ' (#${asset.serialNumber})' : ''}',
                  style: context.text.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                ),
                const Gap(24),
                AsyncBuilder(
                  asyncValue: usersAsync,
                  allowEmpty: true,
                  onLoading: () => AutocompleteBox.loading('User'),
                  builder: (users) {
                    return AutocompleteFormBox<ProfileData>(
                      name: 'userId',
                      label: 'Assign To',
                      placeholder: 'Search and select a user...',
                      items: users,
                      itemLabel: (u) => '${u.firstname} ${u.lastname}',
                      validator: FormBuilderValidators.required(errorText: 'Please select a user'),
                    );
                  },
                ),
                const Gap(16),
                AsyncBuilder(
                  asyncValue: locationsAsync,
                  allowEmpty: true,
                  onLoading: () => AutocompleteBox.loading('Location'),
                  builder: (locations) {
                    return AutocompleteFormBox<LocationModel>(
                      name: 'locationId',
                      label: 'Location (Optional)',
                      placeholder: 'Search and select a location...',
                      items: locations,
                      itemLabel: (l) => l.name,
                    );
                  },
                ),
                const Gap(32),
                FilledButton(
                  onPressed: isLoading.value ? null : onSubmit,
                  child: isLoading.value
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Assign Asset'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
