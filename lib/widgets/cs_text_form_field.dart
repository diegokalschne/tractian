import 'package:flutter/material.dart';

class CsTextFormField extends StatelessWidget {
  const CsTextFormField({
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        fillColor: theme.colorScheme.primaryContainer,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: theme.inputDecorationTheme.border,
        errorBorder: theme.inputDecorationTheme.errorBorder,
        enabledBorder: theme.inputDecorationTheme.enabledBorder,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        disabledBorder: theme.inputDecorationTheme.disabledBorder,
        focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,
      ),
    );
  }
}
