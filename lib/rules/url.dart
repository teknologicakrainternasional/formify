import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_rule.dart';

class URL implements BaseRule {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  URL({
    required this.value,
    required this.attribute,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    RegExp exp = RegExp(r"^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$");
    if (!exp.hasMatch(value)) {
      return FV.buildMessage(customMessage ?? FV.url, attribute);
    }
    return null;
  }
}
