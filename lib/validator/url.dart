import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class URL implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  URL({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    RegExp exp = RegExp(r"^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$");
    if (!exp.hasMatch(value)) {
      return VM.buildMessage(customMessage ?? VM.url, attribute);
    }
    return null;
  }
}
