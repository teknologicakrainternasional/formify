import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_rule.dart';

class AlphaNumeric implements BaseRule {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  AlphaNumeric({
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
    RegExp exp = RegExp(r"^[a-zA-Z0-9]+$");
    if (!exp.hasMatch(value)) {
      return FV.buildMessage(customMessage ?? FV.alphaNum, attribute);
    }
    return null;
  }
}
