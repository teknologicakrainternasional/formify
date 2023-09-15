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
      };
}
