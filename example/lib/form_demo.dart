import 'package:flutter/material.dart';
import 'package:formify/formify.dart';

class FormDemo extends FormifyForms {
  @override
  Map<String, String> get attributes => {
        'username': FT.email,
        'password': FT.password,
      };

  @override
  Map<String, String> get labels => {
        'username': 'Username or Email Address',
      };

  @override
  Map<String, List> get rules => {
        'username': [FR.required],
        'password': [FR.required, FR.min(5)],
      };

  @override
  Map<String, String> get validationMessage =>
      {'min': 'The @attribute minimum contain @extra character'};

  @override
  InputDecoration? get inputDecoration => const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
      );

  @override
  FormifyFormBuilder? get formBuilder => (
        BuildContext context,
        Formify formify,
        FormifyTextField child,
      ) {
        if (formify.attribute == 'username') {
          return child.copyWith(prefixIcon: const Icon(Icons.person));
        }
        if (formify.attribute == 'password') {
          return child.copyWith(prefixIcon: const Icon(Icons.lock));
        }
        return child;
      };

  @override
  FormifySeparatorBuilder? get separatorBuilder => (
        BuildContext context,
        Formify formify,
        Widget child,
      ) {
        return const SizedBox(height: 20);
      };
}
