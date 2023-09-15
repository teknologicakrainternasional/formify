import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class EndsWith implements Validator {
  final String value;
  final String attribute;
  final String pattern;
  final String? customMessage;

  EndsWith({
    required this.value,
    required this.attribute,
    required this.pattern,
    this.customMessage,
  });

  @override
  String? validate() {
    if (!value.endsWith(pattern)) {
      return VM.buildMessage(customMessage ?? VM.endsWith, attribute, pattern);
    }
    return null;
  }
}
