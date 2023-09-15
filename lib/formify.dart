library formify;

import 'package:flutter/material.dart';

import 'formify.dart';

export 'package:formify/formify_forms.dart';
export 'package:formify/widgets/formify_text_field.dart';
export 'package:formify/models/formify_attribute.dart';
export 'package:formify/models/formify_row_attribute.dart';
export 'package:formify/models/_abstract.dart';
export 'package:formify/models/formify_type.dart';
export 'package:formify/validator/validator.dart';

/// A utility class for managing and interacting with a specific form field
/// within a Flutter application.
class Formify {
  /// Creates a new instance of the `Formify` class.
  ///
  /// Parameters:
  /// - `_forms`: The parent `FormifyForms` instance that manages the form data.
  /// - `_attribute`: The name of the attribute associated with this form field.
  /// - `_isLoading`: A flag indicating whether this form field is in a loading state.
  ///
  /// Description:
  /// The `Formify` class provides a convenient way to work with individual form fields
  /// within a Flutter application. It is associated with a specific attribute and
  /// allows you to access information such as its type, validation rules, label, value,
  /// error messages, and more. Additionally, you can interact with the form field by
  /// setting its value, clearing error messages, or toggling the obscured text mode
  /// for password fields.
  Formify(
    this._forms,
    this._attribute, [
    bool isLoading = false,
  ]) : _isLoading = isLoading;

  final FormifyForms _forms;
  final String _attribute;
  final bool _isLoading;

  /// Gets the name of the attribute associated with this form field.
  String get attribute => _attribute;

  /// Gets the type of the form field.
  FormifyType get type => _forms.getAttributeType(attribute);

  /// Gets the validation rules associated with this form field.
  List<FormifyRule> get rules => _forms.getRule(attribute);

  /// Gets the label for this form field.
  String get label => _forms.getLabel(_attribute);

  /// Gets the current value of this form field.
  dynamic get value => _forms.getValue(_attribute);

  /// Gets the error messages associated with this form field.
  List<String>? get errors => _forms.getErrorMessages(_attribute);

  /// Gets the first error message associated with this form field.
  String? get error => _forms.getErrorMessage(_attribute);

  /// Checks if this form field is in a loading state.
  bool get isLoading => _isLoading;

  /// Checks if this form field is required.
  bool get isRequired => _forms.isRequired(attribute);

  /// Gets the form key associated with this form field.
  GlobalKey<FormFieldState> get formKey => _forms.getFormKey(attribute);

  /// Gets the controller for this form field.
  TextEditingController get controller => _forms.getController(attribute);

  /// Gets the keyboard type for this form field (if applicable).
  TextInputType? get keyboardType => type.keyboardType;

  /// Gets the text capitalization for this form field (if applicable).
  TextCapitalization get textCapitalization => type.textCapitalization;

  /// Checks if the text in this form field should be obscured (e.g., for passwords).
  bool get obscureText => _forms.isObscureText(attribute);

  /// Sets the value of this form field.
  ///
  /// Parameters:
  /// - `value`: The new value to set for this form field.
  ///
  /// Description:
  /// Use this method to programmatically set the value of the form field.
  /// It will update the internal state and trigger validation.
  onChanged(dynamic value) => _forms.setValue(attribute, value);

  /// Clears any error messages associated with this form field.
  ///
  /// Description:
  /// Use this method to remove any error messages displayed for this form field.
  clearErrorMessages() => _forms.clearErrorMessages(attribute);

  /// Toggles the obscured text mode for this form field.
  ///
  /// Description:
  /// Use this method to toggle the obscured text mode for fields like passwords.
  /// It will control whether the text is displayed in plain text or obscured.
  toggleObscureText() => _forms.toggleObscureText(attribute);
}
