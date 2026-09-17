import 'dart:io';

import 'package:asset_steward_app/main.export.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

import '../../data/models/profile_data.dart';
import '../controllers/profile_controller.dart';

class EditProfileSheet extends HookConsumerWidget {
  final ProfileData profile;

  const EditProfileSheet({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final selectedImage = useState<XFile?>(null);

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = image;
      }
    }

    return SingleChildScrollView(
      padding: EdgeInsets.only(left: Insets.lg, right: Insets.lg, bottom: context.viewInsets.bottom + Insets.xxl),
      child: FormBuilder(
        key: formKey,
        initialValue: {
          'firstname': profile.firstname,
          'lastname': profile.lastname,
          'gender': profile.gender,
          'dob': profile.dob != null ? DateTime.tryParse(profile.dob!) : null,
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Edit Profile', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Gap(Insets.xl),
            Center(
              child: GestureDetector(
                onTap: pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: selectedImage.value != null
                          ? FileImage(File(selectedImage.value!.path)) as ImageProvider
                          : (profile.profilePicture != null ? NetworkImage(profile.profilePicture!) : null),
                      child: selectedImage.value == null && profile.profilePicture == null
                          ? Text('${profile.firstname[0]}${profile.lastname[0]}', style: context.text.titleLarge)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: context.colors.primary,
                        child: Icon(HIStroke.camera01, size: 16, color: context.colors.onPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(Insets.xl),
            const Row(
              children: [
                Expanded(
                  child: InputField(name: 'firstname', title: 'First Name', isRequired: true),
                ),
                Gap(Insets.md),
                Expanded(
                  child: InputField(name: 'lastname', title: 'Last Name', isRequired: true),
                ),
              ],
            ),
            const Gap(Insets.md),
            Text('Gender', style: context.text.labelLarge),
            const Gap(Insets.xs),
            FormBuilderRadioGroup<String>(
              name: 'gender',
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
              options: [
                'MALE',
                'FEMALE',
                'OTHER',
              ].map((gender) => FormBuilderFieldOption(value: gender, child: Text(gender.titleCase))).toList(),
              wrapSpacing: Insets.lg,
              activeColor: context.colors.primary,
            ),
            const Gap(Insets.md),
            Text('Date of Birth', style: context.text.labelLarge),
            const Gap(Insets.xs),
            FormBuilderDateTimePicker(
              name: 'dob',
              inputType: InputType.date,
              format: DateFormat('yyyy-MM-dd'),
              decoration: const InputDecoration(
                hintText: 'Select Date',
                suffixIcon: Icon(HIStroke.calendar01),
              ),
            ),
            const Gap(Insets.xl),
            FilledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        isLoading.value = true;
                        final form = formKey.currentState!.value;
                        final formDataMap = <String, dynamic>{
                          'firstname': form['firstname'],
                          'lastname': form['lastname'],
                          'gender': form['gender'],
                          if (form['dob'] != null) 'dob': DateFormat('yyyy-MM-dd').format(form['dob'] as DateTime),
                        };

                        if (selectedImage.value != null) {
                          formDataMap['profile_picture'] = await MultipartFile.fromFile(
                            selectedImage.value!.path,
                            filename: selectedImage.value!.name,
                          );
                        }

                        final formData = FormData.fromMap(formDataMap);
                        final result = await ref.read(profileCtrlProvider.notifier).updateProfile(formData);
                        isLoading.value = false;

                        result.fold((l) => Toast.showError(l.message), (r) {
                          Toast.showSuccess('Profile updated successfully!');
                          context.nPop();
                        });
                      }
                    },
              child: isLoading.value ? const Loader(size: 20, color: Colors.white) : const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
