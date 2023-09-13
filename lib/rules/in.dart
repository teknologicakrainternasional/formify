import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class In implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;
  final String extra;

  In({
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
    final extraToList = extra.split(",");
    if (!extraToList.contains(value)) {
      return FV.buildMessage(customMessage ?? FV.inRes, attribute, extra);
    }
    return null;
  }
}