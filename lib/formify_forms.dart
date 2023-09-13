import 'package:flutter/material.dart';
import 'package:formify/extensions/string_extensions.dart';
import 'package:formify/formify.dart';
import 'package:formify/rules/_base_validator.dart';

typedef FormifyFormBuilder = Widget Function(
  BuildContext context,
  String attribute,
  FormifyTextField textField,
  bool isLoading,
  dynamic value,
  List<String>? errors,
);
typedef FormifySeparatorBuilder = Widget Function(
  BuildContext context,
  String attribute,
  Widget child,
  bool isLoading,
);

class FormifyForms {
  FormifyForms();

  ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  Map<String, String> get attributes => {};

  Map<String, String> get labels => {};

  Map<String, List<dynamic>> get rules => {};

  Map<String, String> get validatorMessages => {};

  final Map<String, dynamic> _values = {};

  final Map<String, List<String>> _errors = {};

  final Map<String, GlobalKey<FormFieldState>> _formKeys = {};

  final Map<String, ValueNotifier> _valueNotifiers = {};

  final Map<String, ValueNotifier<List<String>?>> _errorNotifiers = {};

  FormifyFormBuilder? get formBuilder => null;

  FormifySeparatorBuilder? get separatorBuilder => null;

  InputDecoration? get inputDecoration => null;

  setIsLoading(bool value) {
    isLoadingNotifier.value = value;
  }

  //ATTRIBUTE
  String getAttributeType(String attribute) {
    return attributes[attribute] ?? '';
  }

  //VALIDATOR
  List<dynamic> getRule(String attribute) {
    return rules[attribute] ?? [];
  }

  String? getValidatorMessage(String rule) {
    return validatorMessages[rule];
  }

  validateAttribute(String attribute, dynamic value) {
    for (final rule in getRule(attribute)) {
      final errorMessage = _validateAttribute(attribute, value, rule);
      if (errorMessage != null) {
        addErrorMessage(attribute, errorMessage);
      }
    }
    _validateAttributeByKey(attribute);
  }

  bool isFormValid() {
    for (final attribute in attributes.keys) {
      final value = getValue(attribute) ?? '';
      validateAttribute(attribute, value);
    }
    return getErrors().isEmpty;
  }

  //LABEL
  String getLabel(String attribute) {
    String label = labels[attribute] ?? '';
    if (label.isEmpty) {
      label = attribute;
      label = label.replaceAll('_', ' ');
      label = _capitalize(label);
    }

    return label;
  }

  //VALUE
  setValue(String attribute, dynamic value) {
    if (!attributes.containsKey(attribute)) {
      return;
    }
    clearErrorMessages(attribute);
    _values[attribute] = value;
    _getValueNotifier(attribute).value = value;
    validateAttribute(attribute, value);
  }

  dynamic getValue(String attribute) {
    if (!attributes.containsKey(attribute)) {
      return null;
    }
    return _values[attribute];
  }

  Map<String, String> getValues() {
    final Map<String, String> values = Map.from(_values);
    values.removeWhere((key, value) => !attributes.containsKey(key));
    return values;
  }

  //ERRORS
  addErrorMessage(String attribute, String message) {
    if (!attributes.containsKey(attribute)) {
      return;
    }
    List<String> messages = getErrorMessages(attribute) ?? [];
    messages.add(message);
    setErrorMessages(attribute, messages);
  }

  setErrorMessage(String attribute, String message) {
    if (!attributes.containsKey(attribute)) {
      return;
    }
    _errors[attribute] = [message];
    _validateAttributeByKey(attribute);
  }

  setErrorMessages(String attribute, List<String> messages) {
    if (!attributes.containsKey(attribute)) {
      return;
    }
    _errors[attribute] = messages;
  }

  List<String>? getErrorMessages(String attribute) {
    return _errors[attribute];
  }

  String? getErrorMessage(String attribute) {
    List<String> errors = getErrorMessages(attribute) ?? [];
    if (errors.isNotEmpty) {
      return errors[0];
    }
    return null;
  }

  clearErrorMessages(String attribute) {
    _errors.remove(attribute);
  }

  clearAllErrorMessages() {
    _errors.clear();
  }

  Map<String, List<String>> getErrors() {
    final Map<String, List<String>> errors = Map.from(_errors);
    errors.removeWhere((key, value) => !attributes.containsKey(key));
    return errors;
  }

  _validateAttributeByKey(String attribute) {
    _getFormKey(attribute).currentState?.validate() ?? true;
    _getErrorNotifier(attribute).value = getErrorMessages(attribute);
  }

  //GENERATE WIDGETS
  List<Widget> getWidgets() {
    return attributes.keys.map((attribute) {
      final key = _getFormKey(attribute);
      const separator = SizedBox(height: 16);
      final form = FormifyTextField(
        formKey: key,
        label: getLabel(attribute),
        validator: (_) => getErrorMessage(attribute),
        onChanged: (value) => setValue(attribute, value),
        keyboardType: getAttributeType(attribute).keyboardType,
        autovalidateMode: AutovalidateMode.always,
        initialValue: getValue(attribute),
        inputDecoration: inputDecoration,
      );
      return ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (formBuilder != null) ...[
                  ValueListenableBuilder<List<String>?>(
                      valueListenable: _getErrorNotifier(attribute),
                      builder: (context, errors, __) {
                        return ValueListenableBuilder(
                            valueListenable: _getValueNotifier(attribute),
                            builder: (context, value, __) {
                              return formBuilder!(
                                context,
                                attribute,
                                form,
                                isLoading,
                                value,
                                errors,
                              );
                            });
                      }),
                ] else ...[
                  form.copyWith(readOnly: isLoading),
                ],
                if (separatorBuilder != null) ...[
                  separatorBuilder!(context, attribute, separator, isLoading),
                ] else ...[
                  separator
                ],
              ],
            );
          });
    }).toList();
  }

  //PRIVATE
  GlobalKey<FormFieldState> _getFormKey(String attribute) {
    late GlobalKey<FormFieldState> key;
    if (_formKeys[attribute] == null) {
      key = GlobalKey<FormFieldState>();
      _formKeys[attribute] = key;
    }
    key = _formKeys[attribute]!;
    return key;
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

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value.split(' ').map(_capitalizeFirst).join(' ');
  }

  String _capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  String? _validateAttribute(String attribute, dynamic value, dynamic rule) {
    final arrRule = rule.split(":");
    final String actualRule = arrRule[0];
    final String? extra = arrRule.length > 1 ? arrRule[1] : null;
    final String label = getLabel(attribute);
    final String? validatorMessage = getValidatorMessage(actualRule);
    late final BaseValidator? validator;
    if (rule is BaseValidator) {
      validator = rule;
    } else if (rule is String) {
      validator = actualRule.getRuleValidator(
        attribute: label,
        value: value.toString(),
        rule: actualRule,
        extra: extra,
        customMessage: validatorMessage,
      );
    }
    return validator?.validate();
  }
}
