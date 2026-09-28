import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:asset_steward_app/features/locations/presentation/controllers/locations_controller.dart';
import 'package:asset_steward_app/features/profile/data/models/profile_model.dart';
import 'package:asset_steward_app/features/users/presentation/controllers/users_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AssignAssetSheet extends HookConsumerWidget {
  final AssetModel asset;

  final bool isTransfer;

  const AssignAssetSheet({super.key, required this.asset, this.isTransfer = false});

  static Future<bool?> show(BuildContext context, AssetModel asset, {bool isTransfer = false}) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => AssignAssetSheet(asset: asset, isTransfer: isTransfer),
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
        final userId = (data['userId'] as ProfileModel).id;
        final locationId = (data['locationId'] as LocationModel?)?.id;

        final payload = {'assetId': asset.id, 'userId': userId};

        if (locationId != null) {
          payload['locationId'] = locationId;
        }

        final success = isTransfer
            ? await ref.read(assetDetailsCtrlProvider(asset.id).notifier).transferAsset(payload)
            : await ref.read(assetDetailsCtrlProvider(asset.id).notifier).assignAsset(payload);
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
                Text(
                  isTransfer ? 'Transfer Asset' : 'Assign Asset',
                  style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'You are '),
                      TextSpan(text: isTransfer ? 'transferring' : 'assigning'),
                      TextSpan(text: ' ${asset.name}', style: context.text.bodyMedium?.bold),
                    ],
                  ),
                  style: context.text.bodyMedium,
                ),
                // TODO: should show curent user's name
                const Gap(24),
                AsyncBuilder(
                  asyncValue: usersAsync,
                  allowEmpty: true,
                  onLoading: () => AutocompleteBox.loading('User'),
                  builder: (users) {
                    return AutocompleteFormBox<ProfileModel>(
                      name: 'userId',
                      label: isTransfer ? 'Transfer To' : 'Assign To',
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
                      : Text(isTransfer ? 'Transfer Asset' : 'Assign Asset'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
