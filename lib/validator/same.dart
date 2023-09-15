import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Same implements Validator {
  final String value;
  final String attribute;
  final String pattern;
  final String? customMessage;

  Same({
    required this.value,
    required this.attribute,
    required this.pattern,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value != pattern) {
      return VM.buildMessage(customMessage ?? VM.same, attribute, pattern);
    }
    return null;
  }
}
