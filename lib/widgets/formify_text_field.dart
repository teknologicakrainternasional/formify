import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// FormifyTextField
///
/// `FormifyTextField` is a custom Flutter widget that extends `TextFormField` and provides additional configuration options
/// for managing forms. It simplifies form management and allows for easy integration of form fields into your Flutter app.
///
/// Constructor:
///
/// ```dart
/// FormifyTextField({
///   Key? key,
///   String? label,
///   String? initialValue,
///   FocusNode? focusNode,
///   TextInputType? keyboardType,
///   TextCapitalization textCapitalization = TextCapitalization.none,
///   TextInputAction? textInputAction,
///   bool obscureText = false,
///   int? maxLines = 1,
///   int? minLines,
///   ValueChanged<String>? onChanged,
///   GestureTapCallback? onTap,
///   ValueChanged<String>? onFieldSubmitted,
///   FormFieldSetter<String>? onSaved,
///   FormFieldValidator<String>? validator,
///   List<TextInputFormatter>? inputFormatters,
///   bool? enabled,
///   bool readOnly = false,
///   AutovalidateMode? autovalidateMode,
///   String? hintText,
///   Widget? suffixIcon,
///   Widget? prefixIcon,
///   TextEditingController? controller,
///   bool required = false,
///   InputDecoration? inputDecoration,
///   GlobalKey<FormFieldState>? formKey,
/// })
/// ```
///
/// Parameters:
///
/// - `key` (optional): A key to identify the widget.
/// - `label` (optional): The label text displayed above the input field.
/// - `initialValue` (optional): The initial value of the input field.
/// - `focusNode` (optional): The focus node that controls the focus of the input field.
/// - `keyboardType` (optional): The type of keyboard to display (e.g., text, number, email).
/// - `textCapitalization` (optional): The text capitalization style for the input field.
/// - `textInputAction` (optional): The action to be associated with the input field (e.g., next, done).
/// - `obscureText` (optional): Whether the input text should be obscured (e.g., for passwords).
/// - `maxLines` (optional): The maximum number of lines for multiline input.
/// - `minLines` (optional): The minimum number of lines for multiline input.
/// - `onChanged` (optional): Callback function when the input value changes.
/// - `onTap` (optional): Callback function when the input field is tapped.
/// - `onFieldSubmitted` (optional): Callback function when the form field is submitted.
/// - `onSaved` (optional): Callback function for saving the form field's value.
/// - `validator` (optional): Function to validate the input field's value.
/// - `inputFormatters` (optional): List of input formatters for custom input formatting.
/// - `enabled` (optional): Whether the input field is enabled.
/// - `readOnly` (optional): Whether the input field is read-only.
/// - `autovalidateMode` (optional): The mode for automatic validation.
/// - `hintText` (optional): Hint text displayed when the input field is empty.
/// - `suffixIcon` (optional): Widget to be displayed as a suffix icon in the input field.
/// - `prefixIcon` (optional): Widget to be displayed as a prefix icon in the input field.
/// - `controller` (optional): Controller for managing the input field's text.
/// - `required` (optional): Indicates whether the field is required (adds a red asterisk to the label).
/// - `inputDecoration` (optional): Custom input decoration configuration.
/// - `formKey` (optional): Key for linking the `FormifyTextField` with its parent form.
///
/// Methods:
///
/// - `copyWith()`: Creates a copy of the `FormifyTextField` with specific configurations.
///
/// Usage:
///
/// ```dart
/// FormifyTextField(
///   label: 'Email',
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) {
///     if (value == null || value.isEmpty) {
///       return 'Please enter your email address';
///     }
///     // Additional validation logic
///     return null;
///   },
///   // Add more configuration options as needed
/// )
/// ```
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
    this.formKey,
  }) : super(key: key);

  ///Key for linking the `FormifyTextField` with its parent form.
  final GlobalKey<FormFieldState>? formKey;
  ///Indicates whether the field is required (adds a red asterisk to the label).
  final bool required;
  ///The label text displayed above the input field.
  final String? label;
  ///The initial value of the input field.
  final String? initialValue;
  ///The focus node that controls the focus of the input field.
  final FocusNode? focusNode;
  ///The type of keyboard to display (e.g., text, number, email).
  final TextInputType? keyboardType;
  ///The text capitalization style for the input field.
  final TextCapitalization textCapitalization;
  ///The action to be associated with the input field (e.g., next, done).
  final TextInputAction? textInputAction;
  ///Whether the input text should be obscured (e.g., for passwords).
  final bool obscureText;
  ///The maximum number of lines for multiline input.
  final int? maxLines;
  ///The minimum number of lines for multiline input.
  final int? minLines;
  ///Callback function when the input value changes.
  final ValueChanged<String>? onChanged;
  ///Callback function when the input field is tapped.
  final GestureTapCallback? onTap;
  ///Callback function when the form field is submitted.
  final ValueChanged<String>? onFieldSubmitted;
  ///Callback function for saving the form field's value.
  final FormFieldSetter<String>? onSaved;
  ///Function to validate the input field's value.
  final FormFieldValidator<String>? validator;
  ///List of input formatters for custom input formatting.
  final List<TextInputFormatter>? inputFormatters;
  ///Whether the input field is enabled.
  final bool? enabled;
  ///Whether the input field is read-only.
  final bool readOnly;
  ///The mode for automatic validation.
  final AutovalidateMode? autovalidateMode;
  ///Hint text displayed when the input field is empty.
  final String? hintText;
  ///Widget to be displayed as a suffix icon in the input field.
  final Widget? suffixIcon;
  ///Widget to be displayed as a prefix icon in the input field.
  final Widget? prefixIcon;
  ///Controller for managing the input field's text.
  final TextEditingController? controller;
  ///Custom input decoration configuration.
  final InputDecoration? inputDecoration;

  /// mxLine
  ///
  /// The maximum number of lines to be displayed in a `FormifyTextField` widget.
  ///
  /// If the `keyboardType` of the widget is set to `TextInputType.multiline`, this property returns `null` to indicate that
  /// the input field can have an unlimited number of lines. Otherwise, it returns the value of the `maxLines` property.
  ///
  /// This property simplifies the management of the `maxLines` property based on the `keyboardType`.
  int? get mxLine {
    if (keyboardType == TextInputType.multiline) {
      return null;
    }
    return maxLines;
  }

  /// tiAction
  ///
  /// The `TextInputAction` to be associated with a `FormifyTextField` widget.
  ///
  /// If the `keyboardType` of the widget is set to `TextInputType.multiline`, this property returns `null` to indicate that
  /// there is no specific `TextInputAction` associated with the widget. Otherwise, it returns the value of the `textInputAction` property.
  ///
  /// This property simplifies the management of the `textInputAction` property based on the `keyboardType`.
  ///
  TextInputAction? get tiAction {
    if (keyboardType == TextInputType.multiline) {
      return null;
    }
    return textInputAction;
  }

  /// tCapitalization
  ///
  /// The `TextCapitalization` setting for a `FormifyTextField` widget.
  ///
  /// If the `keyboardType` of the widget is set to `TextInputType.name`, this property returns `TextCapitalization.words`
  /// to capitalize the first letter of each word. Otherwise, it returns the value of the `textCapitalization` property.
  ///
  /// This property simplifies the management of the `textCapitalization` property based on the `keyboardType`.
  TextCapitalization get tCapitalization {
    if (keyboardType == TextInputType.name) {
      return TextCapitalization.words;
    }
    return textCapitalization;
  }

  /// iDecoration
  ///
  /// The `InputDecoration` for a `FormifyTextField` widget.
  ///
  /// This property defines the visual appearance of the input field, including labels, icons, and hints.
  /// It takes into account several factors, such as whether the field is required and whether a custom
  /// `inputDecoration` is provided.
  ///
  /// If a custom `inputDecoration` is provided, it returns a copy of that `inputDecoration` with any
  /// missing properties filled in by the corresponding properties of the widget (e.g., `label`, `prefixIcon`,
  /// `suffixIcon`, and `hintText`). This allows you to customize the appearance while still inheriting
  /// some default properties from the widget.
  ///
  /// If the field is marked as required (`required` is set to `true`), it returns an `InputDecoration`
  /// that includes a red asterisk (*) next to the label to indicate the required status.
  ///
  /// If neither a custom `inputDecoration` nor a required field is specified, it returns a basic
  /// `InputDecoration` with the label, prefix icon, suffix icon, and hint text.
  InputDecoration get iDecoration {
    if (inputDecoration != null) {
      return inputDecoration!.copyWith(
          labelText: inputDecoration?.labelText ?? label,
          prefixIcon: inputDecoration?.prefixIcon ?? prefixIcon,
          suffixIcon: inputDecoration?.suffixIcon ?? suffixIcon,
          hintText: inputDecoration?.hintText ?? hintText);
    }
    if (required) {
      return InputDecoration(
        label: Text.rich(
          TextSpan(
            text: label,
            children: const [
              TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
      );
    }
    return InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      key: formKey,
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
      decoration: iDecoration,
      autovalidateMode: autovalidateMode,
    );
  }

  ///Creates a copy of the `FormifyTextField` with specific configurations.
  FormifyTextField copyWith({
    GlobalKey<FormFieldState>? formKey,
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
      initialValue: initialValue ?? this.initialValue,
      formKey: formKey ?? this.formKey,
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
