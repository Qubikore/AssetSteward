import 'package:asset_steward_app/main.export.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

class InputField extends HookWidget {
  const InputField({
    super.key,
    this.title,
    this.name,
    this.hintText,
    this.validators = const [],
    this.isRequired = false,
    this.isPassword = false,
    this.isNumeric = false,
    this.outsideSuffix,
    this.initialValue,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.readOnly = false,
    this.onChanged,
  });

  final String? title;
  final String? name;
  final String? hintText;
  final List<FormFieldValidator<String>> validators;
  final bool isRequired;
  final bool isPassword;
  final bool isNumeric;
  final Widget? outsideSuffix;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool readOnly;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(isPassword);

    final effectiveValidators = <FormFieldValidator<String>>[
      if (isRequired) FormBuilderValidators.required(),
      ...validators,
    ];

    final effectiveKeyboardType = isNumeric ? TextInputType.number : keyboardType;

    final effectiveFormatters = <TextInputFormatter>[
      if (isNumeric) FilteringTextInputFormatter.digitsOnly,
      ...?inputFormatters,
    ];

    Widget? suffixIcon;
    if (isPassword) {
      suffixIcon = IconButton(
        icon: Icon(obscureText.value ? HIStroke.viewOff : HIStroke.view),
        onPressed: () => obscureText.toggle(),
      );
    }

    Widget field;
    if (name != null) {
      field = FormBuilderTextField(
        name: name!,
        initialValue: initialValue,
        controller: controller,
        obscureText: obscureText.value,
        keyboardType: effectiveKeyboardType,
        inputFormatters: effectiveFormatters,
        maxLines: maxLines,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: effectiveValidators.isEmpty ? null : FormBuilderValidators.compose(effectiveValidators),
        decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
      );
    } else {
      field = TextFormField(
        initialValue: initialValue,
        controller: controller,
        obscureText: obscureText.value,
        keyboardType: effectiveKeyboardType,
        inputFormatters: effectiveFormatters,
        maxLines: maxLines,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: effectiveValidators.isEmpty ? null : FormBuilderValidators.compose(effectiveValidators),
        decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
      );
    }

    final hasOutsideSuffix = outsideSuffix != null;

    Widget content = field;
    if (hasOutsideSuffix) {
      content = Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(child: field),
          const Gap(Insets.sm),
          outsideSuffix!,
        ],
      );
    }

    if (title != null) {
      return Column(
        crossAxisAlignment: .start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title!, style: context.text.titleSmall?.medium).required(isRequired),
          const Gap(Insets.xs),
          content,
        ],
      );
    }

    return content;
  }
}
