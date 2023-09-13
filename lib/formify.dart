library formify;

import 'package:flutter/material.dart';

import 'formify.dart';

export 'package:formify/formify_forms.dart';
export 'package:formify/widgets/formify_text_field.dart';
export 'package:formify/constants/ft.dart';
export 'package:formify/constants/fr.dart';
export 'package:formify/constants/fv.dart';
export 'package:formify/rules/_base_validator.dart';

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

  String get label => _forms.getLabel(_attribute);

  dynamic get value => _forms.getValue(_attribute);

  List<String>? get errors => _forms.getErrorMessages(_attribute);

  String? get error => _forms.getErrorMessage(_attribute);

  GlobalKey<FormFieldState> get formKey => _forms.getFormKey(attribute);

  bool get isLoading => _isLoading;

  onChanged(dynamic value) => _forms.setValue(attribute, value);
}
