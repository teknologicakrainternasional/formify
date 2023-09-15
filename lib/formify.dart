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

class Formify {
  Formify(
    this._forms,
    this._attribute, [
    bool isLoading = false,
  ]) : _isLoading = isLoading;

  final FormifyForms _forms;
  final String _attribute;
  final bool _isLoading;

  String get attribute => _attribute;

  FormifyType get type => _forms.getAttributeType(attribute);

  List<FormifyRule> get rules => _forms.getRule(attribute);

  String get label => _forms.getLabel(_attribute);

  dynamic get value => _forms.getValue(_attribute);

  List<String>? get errors => _forms.getErrorMessages(_attribute);

  String? get error => _forms.getErrorMessage(_attribute);

  bool get isLoading => _isLoading;

  bool get isRequired => _forms.isRequired(attribute);

  GlobalKey<FormFieldState> get formKey => _forms.getFormKey(attribute);

  TextEditingController get controller => _forms.getController(attribute);

  TextInputType? get keyboardType => type.keyboardType;

  TextCapitalization get textCapitalization => type.textCapitalization;

  bool get obscureText => _forms.isObscureText(attribute);

  onChanged(dynamic value) => _forms.setValue(attribute, value);

  clearErrorMessages() => _forms.clearErrorMessages(attribute);

  toggleObscureText() => _forms.toggleObscureText(attribute);
}
