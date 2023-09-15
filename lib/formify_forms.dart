import 'package:flutter/material.dart';
import 'package:formify/formify.dart';

/// A typedef for a form widget builder function.
///
/// A `FormifyFormBuilder` is a function that takes a [BuildContext], a [Formify],
/// and a [FormifyTextField] child widget, and returns a custom form widget.
/// This function allows you to customize the appearance and behavior of form
/// widgets generated by `Formify`.
typedef FormifyFormBuilder = Widget Function(
  BuildContext context,
  Formify formify,
  FormifyTextField child,
);

/// A typedef for a custom separator widget builder function.
///
/// A `FormifyFormBuilder` is a function that takes a [BuildContext],
/// and a [Widget] child widget, and returns a custom separator widget.
/// This function allows you to customize the appearance and behavior of
/// separator widgets generated by `Formify`.
typedef FormifySeparatorBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

class FormifyForms {

  final Map<String, dynamic> _values = {};

  final Map<String, List<String>> _errors = {};

  final Map<String, GlobalKey<FormFieldState>> _formKeys = {};

  final Map<String, TextEditingController> _controllers = {};

  final Map<String, ValueNotifier> _valueNotifiers = {};

  final Map<String, ValueNotifier<List<String>?>> _errorNotifiers = {};

  final Map<String, ValueNotifier<bool>> _obscureNotifiers = {};

  final List<String> _overrideObscureText = [];

  Map<String, FormifyType> get _attributes {
    final allAttributes = <String, FormifyType>{};
    for (final fAtt in attributes) {
      if (fAtt is FormifyAttribute) {
        allAttributes[fAtt.attribute] = fAtt.type;
      } else if (fAtt is FormifyRowAttribute) {
        for (final att in fAtt.attributes) {
          allAttributes[att.attribute] = att.type;
        }
      }
    }
    return allAttributes;
  }

  String? _validateAttribute(String attribute, value, FormifyRule rule) {
    String? customMessage = getValidatorMessage(rule.ruleKey);
    if (customMessage != null) {
      rule.message = customMessage;
    }
    return rule(attribute, value.toString());
  }

  Widget _formWidget(FormifyAttribute fAtt) {
    final attribute = fAtt.attribute;
    final length = attributes.length;
    final index = attributes.indexWhere((a) => a.attribute == attribute);
    final isLast = index == length - 1;
    final type = getAttributeType(attribute);
    final formKey = getFormKey(attribute);
    final controller = getController(attribute);
    final required = isRequired(attribute);
    final label = getLabel(attribute);
    final obscureText = isObscureText(fAtt.attribute);
    final textCapitalization = type.textCapitalization;
    final keyboardType = type.keyboardType;
    final form = FormifyTextField(
      formKey: formKey,
      controller: controller,
      obscureText: obscureText,
      label: label,
      required: required,
      onChanged: (value) => setValue(attribute, value),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      autovalidateMode: AutovalidateMode.always,
      inputDecoration: inputDecoration,
      onFieldSubmitted: isLast
          ? onSubmit != null
          ? (value) => onSubmit!()
          : null
          : null,
      textInputAction: isLast ? TextInputAction.send : TextInputAction.next,
    );

    return ValueListenableBuilder<bool>(
        valueListenable: _getObscureNotifiers(attribute),
        builder: (context, isLoading, __) {
          return ValueListenableBuilder<bool>(
              valueListenable: isLoadingNotifier,
              builder: (context, isLoading, __) {
                return ValueListenableBuilder<List<String>?>(
                    valueListenable: _getErrorNotifier(attribute),
                    builder: (context, errors, __) {
                      return ValueListenableBuilder(
                          valueListenable: _getValueNotifier(attribute),
                          builder: (context, value, __) {
                            if (formBuilder != null) {
                              return formBuilder!(
                                context,
                                Formify(this, attribute, isLoading),
                                form.copyWith(
                                  readOnly: isLoading,
                                  obscureText: isObscureText(attribute),
                                ),
                              );
                            } else {
                              return form.copyWith(
                                readOnly: isLoading,
                                obscureText: isObscureText(attribute),
                                validator: (_) => (errors ?? []).isNotEmpty
                                    ? errors![0]
                                    : null,
                              );
                            }
                          });
                    });
              });
        });
  }

  List<Widget> _listFormWidget(FormifyRowAttribute fRAtt) {
    return fRAtt.attributes.map((fAtt) => _formWidget(fAtt)).toList();
  }

  Widget _separatorWidget() {
    const separator = SizedBox(height: 16);
    return Builder(builder: (context) {
      if (separatorBuilder != null) {
        return separatorBuilder!(
          context,
          separator,
        );
      } else {
        return separator;
      }
    });
  }

  Widget _separatorHorizontalWidget() {
    const separator = SizedBox(width: 16);
    return Builder(builder: (context) {
      if (separatorHorizontalBuilder != null) {
        return separatorHorizontalBuilder!(
          context,
          separator,
        );
      } else {
        return separator;
      }
    });
  }

  ValueNotifier _getValueNotifier(String attribute) {
    late ValueNotifier notifier;
    if (_valueNotifiers[attribute] == null) {
      notifier = ValueNotifier(getValue(attribute));
      _valueNotifiers[attribute] = notifier;
    }
    notifier = _valueNotifiers[attribute]!;
    return notifier;
  }

  ValueNotifier<List<String>?> _getErrorNotifier(String attribute) {
    late ValueNotifier<List<String>?> notifier;
    if (_errorNotifiers[attribute] == null) {
      notifier = ValueNotifier(getErrorMessages(attribute));
      _errorNotifiers[attribute] = notifier;
    }
    notifier = _errorNotifiers[attribute]!;
    return notifier;
  }

  ValueNotifier<bool> _getObscureNotifiers(String attribute) {
    late ValueNotifier<bool> notifier;
    if (_obscureNotifiers[attribute] == null) {
      notifier = ValueNotifier(isObscureText(attribute));
      _obscureNotifiers[attribute] = notifier;
    }
    notifier = _obscureNotifiers[attribute]!;
    return notifier;
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value.split(' ').map(_capitalizeFirst).join(' ');
  }

  String _capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /// A [ValueNotifier] for tracking the loading state.
  ///
  /// This [ValueNotifier] is used to monitor loading state value.
  ///
  /// Example usage:
  /// ```dart
  /// ValueListenableBuilder<bool>(
  ///   valueListenable: isLoadingNotifier,
  ///   builder: (context, isLoading, __) {
  ///     return FilledButton(
  ///       onPressed: isLoading?null:() {}
  ///     );
  ///   }
  /// )
  /// ```
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  /// A getter that determine whether automatic validation is enabled or not.
  ///
  /// If the returned value is `true`, validation will be triggered
  /// automatically when the user inputs into the text form field.
  /// If the returned value is `false`, validation will be done
  /// manually, and the user must activate it explicitly.
  bool get isAutoValidation => true;

  /// A getter that returns a list of [Attribute] objects.
  ///
  /// This getter is used to configure what form should Formify render.
  /// It returns a list of [Attribute] objects, which can be of
  /// two types: [FormifyAttribute] and [FormifyRowAttribute].
  ///
  /// - [FormifyAttribute] is used to specify the configuration of a text form
  ///   field, including its type and other properties.
  /// - [FormifyRowAttribute] is used to group multiple [FormifyAttribute]
  ///   instances horizontally within a row.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// List<Attribute> get attributes => [
  ///   FormifyRowAttribute([
  ///     FormifyAttribute('first_name', FormifyType.name),
  ///     FormifyAttribute('last_name', FormifyType.name),
  ///   ]),
  ///   FormifyAttribute('email_address', FormifyType.email),
  ///   FormifyAttribute('password', FormifyType.password),
  /// ];
  /// ```
  List<Attribute> get attributes => [];

  /// A getter that returns a map of validation rules for form fields.
  ///
  /// This getter provides a map where the keys represent the names or identifiers
  /// of form fields, and the corresponding values are lists of [FormifyRule].
  /// Each validation rule is associated with a specific form field and defines
  /// the validation criteria for that field.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Map<String, List<FormifyRule>> get rules => {
  ///   'first_name': [FormifyRule.required],
  ///   'last_name': [FormifyRule.required],
  ///   'email_address': [FormifyRule.required, FormifyRule.email],
  ///   'password': [FormifyRule.required, FormifyRule.min(6)],
  /// };
  /// ```
  Map<String, List<FormifyRule>> get rules => {};

  /// A getter that returns a map of labels for form fields.
  ///
  /// This getter provides a map where the keys represent the names or identifiers
  /// of form fields, and the corresponding values are strings representing
  /// human-readable labels or descriptions for those fields.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Map<String, String> get labels => {
  ///   'email_address': 'Email',
  /// };
  /// ```
  Map<String, String> get labels => {};

  /// A getter that returns a map of validation message for rule.
  ///
  /// This getter provides a map where the keys represent rule key,
  /// and the corresponding values are strings representing custom
  /// validation messages to replace the rule's default validation message.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Map<String, String> get labels => {
  ///   'required': 'This :attribute cannot be empty',
  /// };
  /// ```
  Map<String, String> get validationMessage => {};

  /// A getter that provides a custom form widget builder.
  ///
  /// The `formBuilder` getter returns a `FormifyFormBuilder` function or `null`.
  /// This function can be used to create custom form widgets within the `Formify`
  /// widget. If `null`, the default form widget builder will be used.
  FormifyFormBuilder? get formBuilder => null;

  /// A getter that provides a custom separator widget builder.
  ///
  /// The `formBuilder` getter returns a `FormifySeparatorBuilder` function or `null`.
  /// This function can be used to create custom separator widgets within the `Formify`
  /// widget. If `null`, the default separator widget builder will be used.
  FormifySeparatorBuilder? get separatorBuilder => null;

  /// A getter that provides a custom horizontal separator widget builder.
  ///
  /// The `formBuilder` getter returns a `FormifySeparatorBuilder` function or `null`.
  /// This function can be used to create custom separator widgets within the `Formify`
  /// widget. If `null`, the default separator widget builder will be used.
  FormifySeparatorBuilder? get separatorHorizontalBuilder => null;

  /// A getter that provides custom input decoration for [FormifyTextField].
  ///
  /// The `inputDecoration` getter returns an `InputDecoration` object or `null`.
  /// This object can be used to customize the appearance and behavior of form
  /// field decorations within the `Formify` widget.
  InputDecoration? get inputDecoration => null;

  /// A getter that provides a custom submit callback function for the last text form field.
  ///
  /// The `onSubmit` getter returns a function or `null`. This function can be used
  /// to handle the submission action triggered when the user submits the last
  /// text form field within the `Formify` widget.
  Function()? get onSubmit => null;

  /// Set the loading state.
  ///
  /// The `setIsLoading` function is used to update the loading state represented
  /// by the `isLoadingNotifier`. It allows you to specify whether a loading
  /// operation is in progress or not by setting the value of `isLoadingNotifier`.
  ///
  /// Parameters:
  /// - [value]: A boolean value indicating whether a loading operation is in
  ///   progress (`true`) or not (`false`).
  setIsLoading(bool value) {
    isLoadingNotifier.value = value;
  }

  /// Get the type of a form attribute.
  ///
  /// The `getAttributeType` function is used to retrieve the type of a form attribute
  /// based on its identifier. It looks up the attribute in the internal `_attributes`
  /// map and returns its type. If the attribute is not found, it defaults to
  /// `FormifyType.text`.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve the type.
  ///
  /// Returns:
  /// The type of the specified form attribute as a `FormifyType`, or `FormifyType.text`
  /// if the attribute is not found.
  FormifyType getAttributeType(String attribute) {
    return _attributes[attribute] ?? FormifyType.text;
  }

  /// Get the validation rules for a form attribute.
  ///
  /// The `getRule` function is used to retrieve the validation rules associated
  /// with a specific form attribute based on its identifier. It looks up the
  /// attribute in the `rules` map and returns its associated list of
  /// [FormifyRule] objects. If the attribute is not found, it defaults to an
  /// empty list `[]`.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve the validation rules.
  List<FormifyRule> getRule(String attribute) {
    return rules[attribute] ?? [];
  }

  /// Get a validation message for a specific validation rule.
  ///
  /// The `getValidatorMessage` function is used to retrieve a validation message
  /// associated with a specific validation rule. It looks up the rule in the
  /// `validationMessage` map and returns the corresponding message as a string.
  /// If the rule is not found, it returns `null`.
  ///
  /// Parameters:
  /// - [rule]: The name or identifier of the validation rule for which you want
  ///   to retrieve the validation message.
  ///
  /// Returns:
  /// A list of [FormifyRule] objects representing the validation rules for the
  /// specified form attribute, or an empty list `[]` if the attribute is not found.
  String? getValidatorMessage(String rule) {
    return validationMessage[rule];
  }

  /// Validate a form attribute against its validation rules.
  ///
  /// The `validateAttribute` function is used to validate a form attribute's value
  /// against its associated validation rules. It iterates through the validation
  /// rules for the specified attribute, validates the provided `value` against each
  /// rule, and adds error messages if any validation rule fails.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute to be validated.
  /// - [value]: The value to be validated for the specified form attribute.
  validateAttribute(String attribute, dynamic value) {
    for (final rule in getRule(attribute)) {
      final errorMessage = _validateAttribute(attribute, value, rule);
      if (errorMessage != null) {
        addErrorMessage(attribute, errorMessage);
      }
    }
  }

  /// Check if the form is valid.
  ///
  /// The `isFormValid` function is used to determine whether the entire form is
  /// valid based on its current state. It iterates through all form attributes,
  /// validates their values against their associated validation rules, and checks
  /// if there are any validation errors. If there are no validation errors, the
  /// function returns `true`, indicating that the form is valid. Otherwise, it
  /// returns `false`.
  ///
  /// Returns:
  /// `true` if the form is valid with no validation errors; otherwise, `false`.
  bool isFormValid() {
    for (final attribute in _attributes.keys) {
      final value = getValue(attribute) ?? '';
      validateAttribute(attribute, value);
    }
    return getErrors().isEmpty;
  }

  /// Get a human-readable label for a form attribute.
  ///
  /// The `getLabel` function is used to retrieve a human-readable label for a
  /// specific form attribute. It first looks up the attribute in the `labels` map
  /// to find a custom label. If a custom label is not found, it generates a label
  /// based on the attribute's identifier by replacing underscores with spaces
  /// and capitalizing the first letter of each word.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve a label.
  ///
  /// Returns:
  /// A human-readable label for the specified form attribute.
  String getLabel(String attribute) {
    String label = labels[attribute] ?? '';
    if (label.isEmpty) {
      label = attribute;
      label = label.replaceAll('_', ' ');
      label = _capitalize(label);
    }

    return label;
  }

  /// Set the initial value for a form attribute.
  ///
  /// The `setInitialValue` function is used to set the initial value for a specific
  /// form attribute. It checks if the attribute exists in the `_attributes` map, and
  /// if so, it sets the initial value in the `_values` map, updates the corresponding
  /// `ValueNotifier`, and sets the value in the attribute's controller. If the attribute
  /// does not exist, the function does nothing.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to set
  ///   the initial value.
  /// - [value]: The initial value to be set for the specified form attribute.
  setInitialValue(String attribute, dynamic value) {
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    _values[attribute] = value;
    _getValueNotifier(attribute).value = value;
    getController(attribute).text = value?.toString() ?? '';
  }

  /// Set the initial values for multiple form attributes.
  ///
  /// The `setInitialValues` function is used to set the initial values for multiple
  /// form attributes at once. It takes a `Map` where the keys represent the identifiers
  /// of the form attributes, and the corresponding values are the initial values to be
  /// set. The function iterates through the map and sets the initial values for each
  /// attribute using the `setInitialValue` function.
  ///
  /// Parameters:
  /// - [values]: A `Map` where keys are form attribute identifiers, and values are
  ///   the initial values to be set for each attribute.
  setInitialValues(Map<String, dynamic> values) {
    values.forEach((attribute, value) {
      setInitialValue(attribute, value);
    });
  }

  /// Set the value for a form attribute and optionally trigger validation.
  ///
  /// The `setValue` function is used to set the value for a specific form attribute.
  /// It first checks if the attribute exists in the `_attributes` map. If the attribute
  /// exists, it clears any error messages for the attribute, updates the value in the
  /// `_values` map, and updates the corresponding `ValueNotifier`. Depending on the
  /// `isAutoValidation` flag, it may also trigger validation for the attribute.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to set
  ///   the value.
  /// - [value]: The value to be set for the specified form attribute.
  setValue(String attribute, dynamic value) {
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    clearErrorMessages(attribute);
    _values[attribute] = value;
    _getValueNotifier(attribute).value = value;
    if (isAutoValidation) {
      validateAttribute(attribute, value);
    } else {
      clearErrorMessages(attribute);
    }
  }

  /// Get the current value of a form attribute.
  ///
  /// The `getValue` function is used to retrieve the current value of a specific
  /// form attribute. It first checks if the attribute exists in the `_attributes`
  /// map. If the attribute exists, it returns the current value from the `_values`
  /// map. If the attribute is not found, the function returns `null`.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve the current value.
  dynamic getValue(String attribute) {
    if (!_attributes.containsKey(attribute)) {
      return null;
    }
    return _values[attribute];
  }

  /// Get the current values of all existing form attributes.
  ///
  /// The `getValues` function is used to retrieve the current values of all
  /// existing form attributes. It creates a copy of the `_values` map, removes
  /// entries for attributes that do not exist in the `_attributes` map, and returns
  /// the resulting map of attribute-value pairs.
  ///
  /// Returns:
  /// A map of form attribute identifiers to their corresponding current values.
  Map<String, String> getValues() {
    final Map<String, String> values = Map.from(_values);
    values.removeWhere((key, value) => !_attributes.containsKey(key));
    return values;
  }

  /// Add a custom error message to a form attribute's existing error messages.
  ///
  /// The `addErrorMessage` function is used to add a custom error message to the
  /// existing error messages associated with a specific form attribute. It first
  /// checks if the attribute exists in the `_attributes` map. If the attribute exists,
  /// it retrieves the current error messages, adds the new message to the list, and
  /// updates the error messages for the attribute using the `setErrorMessages` function.
  /// Additionally, it triggers revalidation for the attribute by calling `validate()`
  /// on its associated form key and updates the error notifier with the updated
  /// error messages.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to add
  ///   the custom error message.
  /// - [message]: The custom error message to be added to the form attribute's
  ///   existing error messages.
  addErrorMessage(String attribute, String message) {
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    List<String> messages = getErrorMessages(attribute) ?? [];
    messages.add(message);
    setErrorMessages(attribute, messages);

    getFormKey(attribute).currentState?.validate();
    _getErrorNotifier(attribute).value = getErrorMessages(attribute);
  }

  /// Set a custom error message for a form attribute.
  ///
  /// The `setErrorMessage` function is used to set a custom error message for a
  /// specific form attribute. It first checks if the attribute exists in the
  /// `_attributes` map. If the attribute exists, it sets the custom error message
  /// in the `_errors` map and triggers revalidation for the attribute by calling
  /// `validate()` on its associated form key. Additionally, it updates the error
  /// notifier with the new error message.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to set
  ///   the custom error message.
  /// - [message]: The custom error message to be associated with the form attribute.
  ///
  setErrorMessage(String attribute, String message) {
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    _errors[attribute] = [message];

    getFormKey(attribute).currentState?.validate();
    _getErrorNotifier(attribute).value = getErrorMessages(attribute);
  }

  /// Set custom error messages for a form attribute.
  ///
  /// The `setErrorMessages` function is used to set custom error messages for a
  /// specific form attribute. It first checks if the attribute exists in the
  /// `_attributes` map. If the attribute exists, it sets the custom error messages
  /// in the `_errors` map, triggering revalidation for the attribute by calling
  /// `validate()` on its associated form key. Additionally, it updates the error
  /// notifier with the updated error messages.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to set
  ///   custom error messages.
  /// - [messages]: A list of custom error messages to be associated with the form
  ///   attribute.
  setErrorMessages(String attribute, List<String> messages) {
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    _errors[attribute] = messages;

    getFormKey(attribute).currentState?.validate();
    _getErrorNotifier(attribute).value = getErrorMessages(attribute);
  }

  /// Get the error messages associated with a form attribute.
  ///
  /// The `getErrorMessages` function is used to retrieve the error messages
  /// associated with a specific form attribute. It looks up the attribute in the
  /// `_errors` map and returns the list of error messages. If no custom
  /// error messages are associated with the attribute, the function returns `null`.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve error messages.
  ///
  /// Returns:
  /// A list of error messages associated with the specified form attribute,
  /// or `null` if no error messages are found.
  List<String>? getErrorMessages(String attribute) {
    return _errors[attribute];
  }

  /// Get the first error message associated with a form attribute.
  ///
  /// The `getErrorMessage` function is used to retrieve the first error
  /// message associated with a specific form attribute. It first retrieves the
  /// list of error messages using the `getErrorMessages` function and
  /// checks if there are any error messages. If error messages exist, it returns
  /// the first error message in the list. If no error messages are
  /// associated with the attribute, the function returns `null`.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve the first error message.
  ///
  /// Returns:
  /// The first error message associated with the specified form attribute,
  /// or `null` if no error messages are found.
  String? getErrorMessage(String attribute) {
    List<String> errors = getErrorMessages(attribute) ?? [];
    if (errors.isNotEmpty) {
      return errors[0];
    }
    return null;
  }

  /// Clear error messages associated with a form attribute.
  ///
  /// The `clearErrorMessages` function is used to remove any error messages
  /// associated with a specific form attribute. It removes the entry for the attribute
  /// from the `_errors` map, effectively clearing any error messages associated
  /// with it.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to clear
  ///   error messages.
  clearErrorMessages(String attribute) {
    _errors.remove(attribute);
  }

  /// Clear all error messages associated with the form.
  ///
  /// The `clearAllErrorMessages` function is used to remove all error messages
  /// associated with the entire form. It clears the entire `_errors` map, effectively
  /// removing all error messages for all form attributes.
  clearAllErrorMessages() {
    _errors.clear();
  }

  /// Get error messages associated with form attributes.
  ///
  /// The `getErrors` function is used to retrieve error messages associated
  /// with form attributes that have errors. It creates a copy of the `_errors` map,
  /// removes entries for attributes that do not exist in the `_attributes` map, and
  /// returns the resulting map of attribute-error message pairs.
  ///
  /// Returns:
  /// A map of form attribute identifiers to lists of error messages.
  Map<String, List<String>> getErrors() {
    final Map<String, List<String>> errors = Map.from(_errors);
    errors.removeWhere((key, value) => !_attributes.containsKey(key));
    return errors;
  }

  /// Check if a form attribute is marked as required.
  ///
  /// The `isRequired` function is used to determine whether a specific form attribute
  /// is marked as required. It retrieves the validation rules associated with the
  /// attribute using the `getRule` function and checks if any of those rules are
  /// of the `Required` type. If at least one `Required` validation rule is found,
  /// the function returns `true`, indicating that the attribute is required; otherwise,
  /// it returns `false`.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute to check for being required.
  ///
  /// Returns:
  /// `true` if the form attribute is marked as required; otherwise, `false`.
  bool isRequired(String attribute) {
    final rules = getRule(attribute).where(
      (element) => element.ruleKey == Required.key,
    );
    return rules.isNotEmpty;
  }

  /// Get a `GlobalKey` associated with a form attribute's form field state.
  ///
  /// The `getFormKey` function is used to retrieve a `GlobalKey` associated with
  /// the form field state of a specific form attribute. It ensures that a unique
  /// `GlobalKey` is created and associated with the form field state for the
  /// specified attribute. If a `GlobalKey` already exists for the attribute, it
  /// returns that existing key.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve the `GlobalKey`.
  ///
  /// Returns:
  /// A `GlobalKey` associated with the form field state of the specified attribute.
  ///
  GlobalKey<FormFieldState> getFormKey(String attribute) {
    late GlobalKey<FormFieldState> key;
    if (_formKeys[attribute] == null) {
      key = GlobalKey<FormFieldState>();
      _formKeys[attribute] = key;
    }
    key = _formKeys[attribute]!;
    return key;
  }

  /// Get a `TextEditingController` associated with a form attribute.
  ///
  /// The `getController` function is used to retrieve a `TextEditingController`
  /// associated with a specific form attribute. It ensures that a unique controller
  /// is created and associated with the attribute. If a controller already exists
  /// for the attribute, it returns that existing controller.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute for which you want to
  ///   retrieve the `TextEditingController`.
  ///
  /// Returns:
  /// A `TextEditingController` associated with the specified form attribute.
  TextEditingController getController(String attribute) {
    late TextEditingController controller;
    if (_controllers[attribute] == null) {
      controller = TextEditingController();
      _controllers[attribute] = controller;
    }
    controller = _controllers[attribute]!;
    return controller;
  }

  /// Toggles the obscure text mode for a specific attribute in the form.
  ///
  /// Parameters:
  /// - [attribute]: The name of the attribute for which to toggle obscure text mode.
  ///
  /// Description:
  /// This function allows you to dynamically switch between obscured and
  /// plain text display modes for a text input field associated with the
  /// specified attribute. If the attribute is in `_overrideObscureText`, it
  /// will be removed from the list, effectively enabling plain text display.
  /// If the attribute is not in the list, it will be added to `_overrideObscureText`,
  /// causing the text input field to display its content in obscured form (e.g., for passwords).
  toggleObscureText(String attribute){
    if(_overrideObscureText.contains((attribute))){
      _overrideObscureText.remove(attribute);
    }else{
      _overrideObscureText.add(attribute);
    }
    _getObscureNotifiers(attribute).value = isObscureText(attribute);
  }

  /// Determines whether the text input associated with a specific attribute
  /// should be displayed in obscured (password) mode or not.
  ///
  /// Parameters:
  /// - [attribute]: The name of the attribute for which to determine the text display mode.
  ///
  /// Returns:
  /// - `true` if the text input should be displayed in obscured (password) mode.
  /// - `false` if the text input should be displayed in plain text mode.
  ///
  /// Description:
  /// This function checks if the specified attribute is in the `_overrideObscureText`
  /// list. If it is, it returns `false`, indicating that the text should be displayed
  /// in plain text mode (not obscured). If the attribute is not in the list, it checks
  /// the `obscureText` property of the attribute's type to determine whether the text
  /// should be obscured based on its predefined behavior.
  bool isObscureText(String attribute){
    if(_overrideObscureText.contains((attribute))){
      return false;
    }
    return getAttributeType(attribute).obscureText;
  }

  /// Get a list of widgets corresponding to form attributes.
  ///
  /// The `getWidgets` function is used to generate a list of widgets that correspond
  /// to the form attributes. It iterates through the `attributes` list, and for each
  /// attribute, it generates a widget based on its type (either `FormifyAttribute`
  /// or `FormifyRowAttribute`). For `FormifyAttribute`, it uses the `_formWidget`
  /// function to create the widget. For `FormifyRowAttribute`, it generates a `Row`
  /// widget containing a list of child widgets, each created using `_listFormWidget`.
  /// The function also inserts separator widgets between attribute widgets.
  ///
  /// Returns:
  /// A list of widgets representing the form attributes and separators.
  List<Widget> getWidgets() {
    return attributes
        .map((att) {
          if (att is FormifyAttribute) {
            return _formWidget(att);
          } else if (att is FormifyRowAttribute) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _listFormWidget(att)
                  .map((e) => Expanded(child: e))
                  .toList()
                  .addInBetween(_separatorHorizontalWidget()),
            );
          }
          return const SizedBox();
        })
        .toList()
        .addInBetween(_separatorWidget());
  }
}

extension ListWidgetX on List<Widget> {
  /// Add a widget between each pair of widgets in the list.
  ///
  /// The `addInBetween` extension function is used to insert a specified widget
  /// between each pair of widgets in the list. It iterates through the list of
  /// widgets and inserts the provided `widget` between consecutive widgets in the
  /// original list. The resulting list contains the original widgets and the added
  /// `widget` at the specified positions.
  ///
  /// Parameters:
  /// - [widget]: The widget to be inserted between the existing widgets in the list.
  ///
  /// Returns:
  /// A new list of widgets with the specified `widget` inserted between each pair
  /// of widgets in the original list.
  List<Widget> addInBetween(Widget widget) {
    final widgets = <Widget>[];
    for (int i = 0; i < length; i++) {
      widgets.add(this[i]);
      if (i < length - 1) {
        widgets.add(widget);
      }
    }
    return widgets;
  }
}
