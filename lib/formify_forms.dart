import 'package:flutter/material.dart';
import 'package:formify/extensions/string_extensions.dart';
import 'package:formify/formify.dart';

class FormifyForms {
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Map<String, String> get attributes => {};

  Map<String, String> get labels => {};

  Map<String, List<String>> get validators => {};

  Map<String, String> get validatorMessages => {};

  final Map<String, String> _values = {};

  final Map<String, List<String>> _errors = {};

  //ATTRIBUTE
  String getAttributeType(String attribute) {
    return attributes[attribute] ?? '';
  }

  //VALIDATOR
  List<String> getRule(String attribute) {
    return validators[attribute] ?? [];
  }

  String? getValidatorMessage(String rule) {
    return validatorMessages[rule];
  }

  validateAttribute(String attribute, String value) {
    for (final rule in getRule(attribute)) {
      final errorMessage = _validateAttribute(attribute, value, rule);
      if (errorMessage != null) {
        addErrorMessage(attribute, errorMessage);
      }
    }
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
    validateAttribute(attribute, value);
    print(getRule(attribute));
  }

  bool isValid(){
    return getErrors().isEmpty;
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

  Map<String, String> getErrors() {
    final Map<String, String> errors = Map.from(_errors);
    errors.removeWhere((key, value) => !attributes.containsKey(key));
    return errors;
  }

  //GENERATE WIDGETS
  List<Widget> getWidgets() {
    return attributes.keys.map((attribute) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FormifyTextField(
            label: getLabel(attribute),
            initialValue: getValue(attribute),
            validator: (_) => getErrorMessage(attribute),
            onChanged: (value) => setValue(attribute, value),
            keyboardType: getAttributeType(attribute).keyboardType,
            autovalidateMode: AutovalidateMode.always,
          ),
          const SizedBox(height: 16)
        ],
      );
    }).toList();
  }

  //PRIVATE
  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value.split(' ').map(_capitalizeFirst).join(' ');
  }

  String _capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  String? _validateAttribute(String attribute, String value, String rule) {
    final arrRule = rule.split(":");
    final String actualRule = arrRule[0];
    final String? extra = arrRule.length > 1 ? arrRule[1] : null;
    final String label = getLabel(attribute);
    final String? validatorMessage = getValidatorMessage(actualRule);
    if (FR.allRules.contains(actualRule)) {
      return actualRule
          .getRuleValidator(
            attribute: label,
            value: value,
            rule: actualRule,
            extra: extra,
            customMessage: validatorMessage,
          )
          .validate();
    }
    return null;
  }
}
