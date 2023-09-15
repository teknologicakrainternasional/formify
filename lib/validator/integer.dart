import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Integer implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  Integer({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    final parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      return VM.buildMessage(customMessage ?? VM.integer, attribute);
    }
    return null;
  }
}
