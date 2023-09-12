import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_rule.dart';

class IpAddress implements BaseRule {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  IpAddress({
    required this.value,
    required this.attribute,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if(value.isEmpty){
      return null;
    }
    RegExp exp = RegExp(
        r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$",
        caseSensitive: false,
        multiLine: false);
    if (!exp.hasMatch(value)) {
      return FV.buildMessage(customMessage ?? FV.ip, attribute);
    }
    return null;
  }
}
