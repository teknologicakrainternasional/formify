import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Email implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  Email({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    RegExp exp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
        caseSensitive: false);
    if (!exp.hasMatch(value)) {
      return VM.buildMessage(customMessage ?? VM.email, attribute);
    }
    return null;
  }
}
