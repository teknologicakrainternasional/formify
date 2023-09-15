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
        'phone_number': [FormifyRule.required, MyPhoneValidation()],
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
  InputDecoration? get inputDecoration => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      );

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
        if (formify.attribute == 'address') {
          return child.copyWith(
            minLines: 5,
          );
        }
        return child;
      };
}

class MyPhoneValidation extends FormifyRule{
  @override
  String? call(String attribute, String value) {
    RegExp phoneNumberRegex = RegExp(r'^\+26\d{10,}$');
    if (!phoneNumberRegex.hasMatch(value)) {
      return '$attribute should start with +26 and minimum 12 digit';
    }
    return null;
  }
}