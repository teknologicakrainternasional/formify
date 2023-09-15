import 'package:flutter/material.dart';
import 'package:formify/formify.dart';

class FormDemo extends FormifyForms {
  @override
  List<Attribute> get attributes => [
        FormifyAttribute('first_name', FormifyType.name),
        FormifyAttribute('last_name', FormifyType.name),
        FormifyRowAttribute([
          FormifyAttribute('phone_number', FormifyType.phone),
          FormifyAttribute('email_address', FormifyType.email),
        ]),
        FormifyAttribute('address', FormifyType.multiline),
        FormifyAttribute('postal_code', FormifyType.numeric),
        FormifyAttribute('password', FormifyType.password),
      ];

  @override
  Map<String, List<FormifyRule>> get rules => {
        'first_name': [FormifyRule.required],
        'last_name': [FormifyRule.required],
        'phone_number': [FormifyRule.required],
        'email_address': [FormifyRule.email],
        'address': [FormifyRule.required],
        'postal_code': [
          FormifyRule.required,
          FormifyRule.min(5),
          FormifyRule.max(5),
        ],
        'password': [
          FormifyRule.required,
          FormifyRule.min(5),
        ],
      };

  @override
  FormifyFormBuilder? get formBuilder => (
        context,
        Formify formify,
        FormifyTextField child,
      ) {
        if (formify.attribute == 'password') {
          return child.copyWith(
            suffixIcon: IconButton(
              onPressed: formify.toggleObscureText,
              icon: formify.obscureText
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
          );
        }
        return child;
      };
}
