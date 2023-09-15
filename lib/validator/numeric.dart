import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Numeric implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  Numeric({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    final parsedValue = num.tryParse(value);
    if (parsedValue == null) {
      return VM.buildMessage(customMessage ?? VM.numeric, attribute);
    }
    return null;
  }
}
