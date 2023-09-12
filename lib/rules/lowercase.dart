import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_rule.dart';

class LowerCase implements BaseRule {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  LowerCase({
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
    if (value.toLowerCase() != value) {
      return FV.buildMessage(customMessage ?? FV.lowercase, attribute);
    }
    return null;
  }
}
