import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class RegEx implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String extra;
  final String? customMessage;
  final String? customLabel;

  RegEx({
    required this.value,
    required this.attribute,
    required this.extra,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if(value.isEmpty){
      return null;
    }
    RegExp exp = RegExp(extra);
    if (!exp.hasMatch(value)) {
      return FV.buildMessage(customMessage ?? FV.regex, attribute, extra);
    }
    return null;
  }
}
