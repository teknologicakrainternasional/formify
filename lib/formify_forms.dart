import 'package:flutter/material.dart';
import 'package:formify/extensions/string_extensions.dart';
import 'package:formify/formify.dart';

typedef FormifyFormBuilder = Widget Function(
  BuildContext context,
  Formify formify,
  FormifyTextField child,
);
typedef FormifySeparatorBuilder = Widget Function(
  BuildContext context,
  Formify formify,
  Widget child,
);

class FormifyForms {
  FormifyForms();

  ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  bool get isAutoValidation => true;

  Map<String, String> get attributes => {};

  Map<String, String> get labels => {};

  Map<String, List<dynamic>> get rules => {};

  Map<String, String> get validationMessage => {};

  final Map<String, dynamic> _values = {};

  final Map<String, List<String>> _errors = {};

  final Map<String, GlobalKey<FormFieldState>> _formKeys = {};

  final Map<String, ValueNotifier> _valueNotifiers = {};

  final Map<String, ValueNotifier<List<String>?>> _errorNotifiers = {};

  FormifyFormBuilder? get formBuilder => null;

  FormifySeparatorBuilder? get separatorBuilder => null;

  InputDecoration? get inputDecoration => null;

  Function(String)? get onSubmit => null;

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
    return validationMessage[rule];
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

  String? _validateAttribute(String attribute, dynamic value, dynamic rule) {
    if (rule is FormFieldValidator) {
      return rule.call(value);
    } else if (rule is String) {
      final arrRule = rule.split(":");
      final String actualRule = arrRule[0];
      final String? extra = arrRule.length > 1 ? arrRule[1] : null;
      final String label = getLabel(attribute);
      final String? validatorMessage = getValidatorMessage(actualRule);
      return actualRule
          .getRuleValidator(
            attribute: label,
            value: value.toString(),
            rule: actualRule,
            extra: extra,
            customMessage: validatorMessage,
          )
          ?.validate();
    }

    return null;
  }

  _validateAttributeByKey(String attribute) {
    getFormKey(attribute).currentState?.validate() ?? true;
    _getErrorNotifier(attribute).value = getErrorMessages(attribute);
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
  setInitialValue(String attribute, dynamic value) {
    if (!attributes.containsKey(attribute)) {
      return;
    }
    _values[attribute] = value;
  }

  setInitialValues(Map<String, dynamic> values) {
    values.removeWhere((key, value) => !attributes.containsKey(key));
    _values.addAll(values);
  }

  setValue(String attribute, dynamic value) {
    if (!attributes.containsKey(attribute)) {
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
    _validateAttributeByKey(attribute);
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

  //GENERATE WIDGETS
  List<Widget> getWidgets() {
    return attributes.keys.map((attribute) {
      final attrs = attributes.keys.toList();
      final length = attrs.length;
      final isLast = attrs.indexWhere((a) => a == attribute) == length - 1;
      final key = getFormKey(attribute);
      final type = getAttributeType(attribute);
      final obscure = type == FT.password;
      const separator = SizedBox(height: 16);
      final form = FormifyTextField(
        formKey: key,
        obscureText: obscure,
        label: getLabel(attribute),
        validator: (_) => getErrorMessage(attribute),
        onChanged: (value) => setValue(attribute, value),
        keyboardType: getAttributeType(attribute).keyboardType,
        autovalidateMode: AutovalidateMode.always,
        //initialValue: getValue(attribute),
        inputDecoration: inputDecoration,
        onFieldSubmitted: isLast ? onSubmit : null,
        textInputAction: isLast ? TextInputAction.send : TextInputAction.next,
      );
      return ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ValueListenableBuilder<List<String>?>(
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
                                  initialValue: value?.toString(),
                                ),
                              );
                            } else {
                              return form.copyWith(
                                readOnly: isLoading,
                                initialValue: value?.toString(),
                              );
                            }
                          });
                    }),
                if (separatorBuilder != null) ...[
                  separatorBuilder!(
                    context,
                    Formify(this, attribute, isLoading),
                    separator,
                  ),
                ] else ...[
                  separator
                ],
              ],
            );
          });
    }).toList();
  }

  //OTHER
  GlobalKey<FormFieldState> getFormKey(String attribute) {
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
}
