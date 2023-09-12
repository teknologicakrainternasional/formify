import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_rule.dart';

class Numeric implements BaseRule {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  Numeric({
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
    final parsedValue = num.tryParse(value);
    if (parsedValue == null) {
      return FV.buildMessage(customMessage ?? FV.numeric, attribute);
    }
    return null;
  }
}
