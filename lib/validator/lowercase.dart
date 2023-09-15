import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class LowerCase implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  LowerCase({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    if (value.toLowerCase() != value) {
      return VM.buildMessage(customMessage ?? VM.lowercase, attribute);
    }
    return null;
  }
}
