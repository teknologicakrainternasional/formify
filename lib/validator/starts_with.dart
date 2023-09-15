import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class StartsWith implements Validator {
  final String value;
  final String attribute;
  final String pattern;
  final String? customMessage;

  StartsWith({
    required this.value,
    required this.attribute,
    required this.pattern,
    this.customMessage,
  });

  @override
  String? validate() {
    if (!value.startsWith(pattern)) {
      return VM.buildMessage(customMessage ?? VM.startsWith, attribute, pattern);
    }
    return null;
  }
}
