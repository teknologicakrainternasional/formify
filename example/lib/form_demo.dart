import 'package:flutter/material.dart';
import 'package:formify/formify.dart';

const defaultBorder = BorderSide(
  color: Colors.grey,
  width: 1,
);
const focusBorder = BorderSide(
  color: Colors.blue,
  width: 2,
);
const errorBorder = BorderSide(
  color: Colors.red,
  width: 1,
);
final outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);

final decoration = InputDecoration(
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: outlineInputBorder.copyWith(
    borderSide: focusBorder,
  ),
  errorBorder: outlineInputBorder.copyWith(
    borderSide: errorBorder,
  ),
  focusedErrorBorder: outlineInputBorder.copyWith(
    borderSide: errorBorder.copyWith(width: 2),
  ),
);

class FormDemo extends FormifyForms {
  @override
  InputDecoration? get inputDecoration => decoration;

  @override
  FormifyFormBuilder? get formBuilder =>
      (context, attribute, textField, isLoading, value, errors) {
        if (attribute == 'job_title') {
          print("ERRORS: $errors");
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(
                      value: '',
                      child: Text('NONE'),
                    ),
                    DropdownMenuItem(
                      value: 'Backend',
                      child: Text('Backend'),
                    ),
                    DropdownMenuItem(
                      value: 'Frontend',
                      child: Text('Frontend'),
                    ),
                    DropdownMenuItem(
                      value: 'Mobile',
                      child: Text('Mobile'),
                    ),
                  ],
                  onChanged: (value) => setValue(attribute, value),
                  value: value,
                ),
              ),
              if(errors?.isNotEmpty??false)...[
                Text(errors![0], style: const TextStyle(color: Colors.red),)
              ]
            ],
          );
        }
        return textField;
      };

  @override
  Map<String, String> get attributes => {
        'first_name': FT.name,
        'last_name': FT.name,
        'email': FT.email,
        'phone_number': FT.phone,
        'company_name': FT.name,
        'job_title': FT.name,
        'number_employee': FT.numeric,
      };

  @override
  Map<String, List<String>> get rules => {
        'first_name': [FR.required],
        'last_name': [FR.required],
        'email': [FR.required, FR.email],
        'phone_number': [FR.required],
        'company_name': [FR.required],
        'job_title': [FR.required],
        'number_employee': [FR.required, FR.numeric],
      };

  @override
  Map<String, String> get labels => {
        'first_name': 'Nama Depan',
      };
}
