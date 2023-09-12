import 'package:formify/formify.dart';

class FormDemo extends FormifyForms {
  @override
  Map<String, String> get attributes => {
        'text': FT.text,
        'numeric': FT.numeric,
        'password': FT.password,
        'email': FT.email,
        'multiline': FT.multiline,
        'phone': FT.phone,
      };

  @override
  Map<String, List<String>> get validators => {
        'text': [FR.required],
      };
}
