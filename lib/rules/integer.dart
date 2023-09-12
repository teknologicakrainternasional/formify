import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_rule.dart';

class Integer implements BaseRule {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  Integer({
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
    final parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      return FV.buildMessage(customMessage ?? FV.integer, attribute);
    }
    return null;
  }
}
