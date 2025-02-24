import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../res/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.hint,
    super.key,
    this.error,
    this.obscureText = false,
    this.textStyle,
    this.hintStyle,
    this.decoration,
    this.keyboardAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validators,
    this.inputFormatters,
    this.maxLength,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.obscuringCharacter,
    this.onTap,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.initValue,
    this.onSubmitted,
    this.paddingLeft = false,
    this.contentPadding,
    this.prefixIcon,
    this.onSaved,
    this.prefixText,
    this.maxLines = 1,
    this.minLise = 1,
    this.height = 1,
    this.filled = true,
    this.fillColor = AppColor.textFieldSecondaryColor,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.errorText,
    this.buildCounter,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.isDense,
    this.autocorrect = true,
    this.borderRadius,
    this.cursorColor,
    this.enableSuggestions,
    this.autovalidateMode,
    this.borderColor,
    this.addDisabledBorder = false,
  });

  final String label;
  final String hint;
  final String? prefixText;
  final String? errorText;
  final String? error;
  final bool obscureText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final TextInputAction keyboardAction;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validators;
  final List<TextInputFormatter>? inputFormatters;
  final InputCounterWidgetBuilder? buildCounter;
  final int? maxLength;
  final Widget? prefixIcon;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final Widget? suffixIcon;
  final String? initValue;
  final FormFieldSetter<String>? onSaved;
  final bool paddingLeft;
  final EdgeInsets? contentPadding;
  final int maxLines;
  final int minLise;
  final double height;
  final bool filled;
  final Color fillColor;
  final Widget? suffix;
  final Widget? prefix;
  final ValueSetter<String?>? onChanged;
  final VoidCallback? onSubmitted;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final bool? isDense;
  final bool? autocorrect;
  final String? obscuringCharacter;
  final double? borderRadius;
  final Color? cursorColor;
  final Color? borderColor;
  final bool? enableSuggestions;
  final bool addDisabledBorder;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      initialValue: initValue,
      onSaved: onSaved,
      cursorColor: cursorColor ?? Colors.black,
      enableInteractiveSelection: enableInteractiveSelection,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      minLines: minLise,
      maxLines: maxLines,
      autovalidateMode: autovalidateMode,
      obscuringCharacter: obscuringCharacter ?? '*',
      style: textStyle ??
          TextStyle(
            color: fillColor == AppColor.textFieldSecondaryColor ? AppColor.textDarkColor : AppColor.textTertiary,
            fontSize: 16,
          ),
      obscureText: obscureText,
      validator: validators ??
          (value) {
            return null;
          },
      keyboardType: keyboardType,
      textInputAction: keyboardAction,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      onFieldSubmitted: (_) => submit(context),
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: decoration ??
          InputDecoration(
            counterStyle: TextStyle(color: AppColor.textColor.withOpacity(0.50)),
            counterText: '',
            prefixText: prefixText,
            isDense: isDense,
            prefix: prefix,
            prefixStyle: TextStyle(color: Colors.black),
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            filled: filled,
            fillColor: fillColor,
            hintText: hint,
            hintMaxLines: 1,
            suffixIcon: suffixIcon,
            suffix: suffix,
            suffixIconConstraints: suffixIconConstraints,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: hintStyle ?? textStyle ?? TextStyle(color: Theme.of(context).hintColor),
            errorStyle: TextStyle(
              fontSize: 16,
            ),
            errorMaxLines: 2,
            labelStyle: TextStyle(fontSize: 16, color: AppColor.textColor),
            alignLabelWithHint: true,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: filled
                  ? (fillColor == AppColor.textFieldSecondaryColor)
                      ? BorderSide(color: Theme.of(context).primaryColor)
                      : (borderColor != null)
                          ? BorderSide(color: borderColor!, width: 0.5)
                          : BorderSide.none
                  : BorderSide(color: Theme.of(context).primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: filled
                  ? (fillColor == AppColor.textFieldSecondaryColor)
                      ? const BorderSide(color: AppColor.greyColor)
                      : (borderColor != null)
                          ? BorderSide(color: borderColor!, width: 0.5)
                          : BorderSide.none
                  : BorderSide(color: Theme.of(context).primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: const BorderSide(
                color: AppColor.errorColor,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: addDisabledBorder ? BorderSide(color: borderColor ?? AppColor.colorHint) : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: const BorderSide(
                color: AppColor.errorColor,
                width: 2,
              ),
            ),
          ),
    );
  }

  void submit(BuildContext context) {
    onSubmitted?.call();
    switch (keyboardAction) {
      case TextInputAction.done:
        FocusScope.of(context).unfocus();
      case TextInputAction.next:
        FocusScope.of(context).requestFocus(nextFocusNode);
      // ignore: no_default_cases
      default:
        FocusScope.of(context).nextFocus();
    }
  }
}
