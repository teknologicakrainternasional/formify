import 'package:formify/formify.dart';

class FormDemo extends FormifyForms {
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
  Map<String, List<String>> get validators => {
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
