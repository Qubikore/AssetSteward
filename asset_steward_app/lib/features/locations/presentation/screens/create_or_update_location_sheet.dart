import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/location_model.dart';
import '../controllers/locations_controller.dart';

class CreateOrUpdateLocationSheet extends HookConsumerWidget {
  final LocationModel? location;

  const CreateOrUpdateLocationSheet({super.key, this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    return SingleChildScrollView(
      padding: EdgeInsets.only(left: Insets.lg, right: Insets.lg, bottom: context.viewInsets.bottom + Insets.xxl),
      child: FormBuilder(
        key: formKey,
        initialValue: {'name': location?.name, 'address': location?.address},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(Insets.md),
            Text(
              location == null ? 'New Location' : 'Edit Location',
              style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Gap(Insets.xl),
            const InputField(
              name: 'name',
              title: 'Name',
              hintText: 'Enter location name',
              isRequired: true,
              keyboardType: TextInputType.name,
            ),
            const Gap(Insets.md),
            const InputField(
              name: 'address',
              title: 'Address',
              hintText: 'Enter location address',
              keyboardType: TextInputType.streetAddress,
            ),
            const Gap(Insets.xxl),
            FilledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      final state = formKey.currentState!;

                      if (!state.saveAndValidate()) return;

                      isLoading.value = true;

                      final data = state.value;
                      final notifier = ref.read(locationsCtrlProvider.notifier);

                      try {
                        if (location == null) {
                          final result = await notifier.createLocation(data);

                          result.fold((l) => Toast.showError(l.message), (r) {
                            Toast.showSuccess('Location created successfully');
                            if (context.mounted) context.nPop();
                          });
                        } else {
                          final result = await notifier.updateLocation(location!.id, data);
                          result.fold((l) => Toast.showError(l.message), (r) {
                            Toast.showSuccess('Location updated successfully');
                            if (context.mounted) context.nPop();
                          });
                        }
                      } finally {
                        isLoading.value = false;
                      }
                    },
              child: isLoading.value
                  ? const Loader(size: 20, color: Colors.white)
                  : Text(location == null ? 'Create Location' : 'Update Location'),
            ),
          ],
        ),
      ),
    );
  }
}
