import 'package:flutter/material.dart';
import 'package:formify/formify.dart';

class FormDemo extends FormifyForms {
  @override
  FormifyFormBuilder? get formBuilder => (context, formify, child) {
        return Column(
          children: [
            DropdownButton<int>(
              value: formify.value,
              items: [1, 2, 3]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text("$e"),
                      ))
                  .toList(),
              onChanged: formify.onChanged,
            ),
            if (formify.error != null) ...[
              Text(formify.error!),
            ],
          ],
        );
      };

  @override
  Map<String, String> get attributes => {
        'test': FT.text,
      };

  @override
  Map<String, List<dynamic>> get rules => {
        'test': [FR.required, customValidation],
      };

  String? customValidation(value) {
    if (value == 1) {
      return 'OKOK WAE';
    }
    return null;
  }
}
