import 'package:flutter/material.dart';
import 'package:formify/formify.dart';

typedef FormifyFormBuilder = Widget Function(
    BuildContext context,
    Formify formify,
    FormifyTextField child,
    );
typedef FormifySeparatorBuilder = Widget Function(
    BuildContext context,
    Widget child,
    );

class FormifyForms {
  FormifyForms();

  ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  bool get isAutoValidation => true;

  List<Attribute> get attributes => [];

  Map<String, List<FormifyRule>> get rules => {};

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

  Map<String, String> get labels => {};

  Map<FormifyRuleEnum, String> get validationMessage => {};

  final Map<String, dynamic> _values = {};

  final Map<String, List<String>> _errors = {};

  final Map<String, GlobalKey<FormFieldState>> _formKeys = {};

  final Map<String, TextEditingController> _controllers = {};

  final Map<String, ValueNotifier> _valueNotifiers = {};

  final Map<String, ValueNotifier<List<String>?>> _errorNotifiers = {};

  FormifyFormBuilder? get formBuilder => null;

  FormifySeparatorBuilder? get separatorBuilder => null;

  FormifySeparatorBuilder? get separatorHorizontalBuilder => null;

  InputDecoration? get inputDecoration => null;

  Function()? get onSubmit => null;

  setIsLoading(bool value) {
    isLoadingNotifier.value = value;
  }

  //ATTRIBUTE
  FormifyType getAttributeType(String attribute) {
    return _attributes[attribute] ?? FormifyType.text;
  }

  //VALIDATOR
  List<dynamic> getRule(String attribute) {
    return rules[attribute] ?? [];
  }

  String? getValidatorMessage(FormifyRuleEnum rule) {
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
    } else if (rule is FormifyRule) {
      return rule.validate(getLabel(attribute), value, getValidatorMessage(rule.rule));
    }

    return null;
  }

  _validateAttributeByKey(String attribute) {
    getFormKey(attribute).currentState?.validate();
    _getErrorNotifier(attribute).value = getErrorMessages(attribute);
  }

  bool isFormValid() {
    for (final attribute in _attributes.keys) {
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
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    _values[attribute] = value;
    _getValueNotifier(attribute).value = value;
    getController(attribute).text = value?.toString()??'';
  }

  setInitialValues(Map<String, dynamic> values) {
    values.forEach((attribute, value) {
      setInitialValue(attribute, value);
    });
  }

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

  dynamic getValue(String attribute) {
    if (!_attributes.containsKey(attribute)) {
      return null;
    }
    return _values[attribute];
  }

  Map<String, String> getValues() {
    final Map<String, String> values = Map.from(_values);
    values.removeWhere((key, value) => !_attributes.containsKey(key));
    return values;
  }

  //ERRORS
  addErrorMessage(String attribute, String message) {
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    List<String> messages = getErrorMessages(attribute) ?? [];
    messages.add(message);
    setErrorMessages(attribute, messages);
  }

  setErrorMessage(String attribute, String message) {
    if (!_attributes.containsKey(attribute)) {
      return;
    }
    _errors[attribute] = [message];
    _validateAttributeByKey(attribute);
  }

  setErrorMessages(String attribute, List<String> messages) {
    if (!_attributes.containsKey(attribute)) {
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
    errors.removeWhere((key, value) => !_attributes.containsKey(key));
    return errors;
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
    final obscureText = type.obscureText;
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
                          form.copyWith(readOnly: isLoading),
                        );
                      } else {
                        return form.copyWith(
                          readOnly: isLoading,
                          validator: (_) =>
                              (errors ?? []).isNotEmpty ? errors![0] : null,
                        );
                      }
                    });
              });
        });
  }

  List<Widget> _listFormWidget(FormifyRowAttribute fRAtt) {
    return fRAtt.attributes
        .map((fAtt) => _formWidget(fAtt))
        .toList();
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

  //GENERATE WIDGETS
  List<Widget> getWidgets() {
    return attributes.map((att){
      if(att is FormifyAttribute){
        return _formWidget(att);
      }else if(att is FormifyRowAttribute){
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _listFormWidget(att)
              .map((e) => Expanded(child: e))
              .toList()
              .addInBetween(_separatorHorizontalWidget()),
        );
      }
      return const SizedBox();
    }).toList().addInBetween(_separatorWidget());
  }

  //OTHER
  bool isRequired(String attribute) {
    final rules = getRule(attribute).where(
          (element) =>
      element is FormifyRule && element.rule == FormifyRuleEnum.required,
    );
    return rules.isNotEmpty;
  }

  GlobalKey<FormFieldState> getFormKey(String attribute) {
    late GlobalKey<FormFieldState> key;
    if (_formKeys[attribute] == null) {
      key = GlobalKey<FormFieldState>();
      _formKeys[attribute] = key;
    }
    key = _formKeys[attribute]!;
    return key;
  }

  TextEditingController getController(String attribute) {
    late TextEditingController controller;
    if (_controllers[attribute] == null) {
      controller = TextEditingController();
      _controllers[attribute] = controller;
    }
    controller = _controllers[attribute]!;
    return controller;
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

extension ListWidgetX on List<Widget>{
  List<Widget> addInBetween(Widget widget) {
    final widgets = <Widget>[];
    for (int i = 0; i < length; i++) {
      widgets.add(this[i]);
      if (i < length-1){
        widgets.add(widget);
      }
    }
    return widgets;
  }
}
