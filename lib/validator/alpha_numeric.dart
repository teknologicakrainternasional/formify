import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class AlphaNumeric implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  AlphaNumeric({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    RegExp exp = RegExp(r"^[a-zA-Z0-9]+$");
    if (!exp.hasMatch(value)) {
      return VM.buildMessage(customMessage ?? VM.alphaNum, attribute);
    }
    return null;
  }
}
