import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_rule.dart';

class Min implements BaseRule {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;
  final String extra;

  Min({
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
    final parsedExtra = num.tryParse(extra);
    if (parsedExtra == null) {
      return FV.buildMessage(FV.numeric, attribute);
    }

    if (value.length < parsedExtra) {
      return FV.buildMessage(customMessage ?? FV.min, attribute, extra);
    }
    return null;
  }
}
