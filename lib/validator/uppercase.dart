import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class UpperCase implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  UpperCase({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    if (value.toUpperCase() != value) {
      return VM.buildMessage(customMessage ?? VM.uppercase, attribute);
    }
    return null;
  }
}
