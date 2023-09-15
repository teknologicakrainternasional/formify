import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Required implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  Required({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return VM.buildMessage(customMessage ?? VM.required, attribute);
    }
    return null;
  }
}
