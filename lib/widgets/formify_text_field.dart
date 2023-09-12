import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormifyTextField extends StatelessWidget {
  const FormifyTextField({
    Key? key,
    this.label,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.readOnly = false,
    this.autovalidateMode,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.required = false,
    this.inputDecoration,
  }) : super(key: key);

  final bool required;
  final String? label;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool readOnly;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;

  int? get mxLine {
    if(keyboardType == TextInputType.multiline){
      return null;
    }
    return maxLines;
  }

  TextInputAction? get tiAction {
    if(keyboardType == TextInputType.multiline){
      return null;
    }
    return textInputAction;
  }

  TextCapitalization get tCapitalization {
    if(keyboardType == TextInputType.name){
      return TextCapitalization.words;
    }
    return textCapitalization;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      key: key,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textCapitalization: tCapitalization,
      textInputAction: tiAction,
      obscureText: obscureText,
      autocorrect: false,
      enableSuggestions: false,
      maxLines: mxLine,
      minLines: minLines,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      readOnly: readOnly,
      decoration: inputDecoration ?? InputDecoration(labelText: label),
      autovalidateMode: autovalidateMode,
    );
  }

  FormifyTextField copyWith({
    bool? required,
    String? label,
    String? initialValue,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    bool? obscureText,
    int? maxLines,
    int? minLines,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    bool? readOnly,
    AutovalidateMode? autovalidateMode,
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextEditingController? controller,
    InputDecoration? inputDecoration,
  }) {
    return FormifyTextField(
      required: required ?? this.required,
      label: label ?? this.label,
      focusNode: focusNode ?? this.focusNode,
      keyboardType: keyboardType ?? this.keyboardType,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      textInputAction: textInputAction ?? this.textInputAction,
      obscureText: obscureText ?? this.obscureText,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      onChanged: onChanged ?? this.onChanged,
      onTap: onTap ?? this.onTap,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onSaved: onSaved ?? this.onSaved,
      validator: validator ?? this.validator,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enabled: enabled ?? this.enabled,
      readOnly: readOnly ?? this.readOnly,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      hintText: hintText ?? this.hintText,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      controller: controller ?? this.controller,
      inputDecoration: inputDecoration ?? this.inputDecoration,
    );
  }
}
