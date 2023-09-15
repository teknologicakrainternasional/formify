import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class RegEx implements Validator {
  final String value;
  final String attribute;
  final String pattern;
  final String? customMessage;

  RegEx({
    required this.value,
    required this.attribute,
    required this.pattern,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    RegExp exp = RegExp(pattern);
    if (!exp.hasMatch(value)) {
      return VM.buildMessage(customMessage ?? VM.regex, attribute, pattern);
    }
    return null;
  }
}
