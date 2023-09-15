import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class IpAddress implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  IpAddress({
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
        r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$",
        caseSensitive: false,
        multiLine: false);
    if (!exp.hasMatch(value)) {
      return VM.buildMessage(customMessage ?? VM.ip, attribute);
    }
    return null;
  }
}
