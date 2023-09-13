import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class EndsWith implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String extra;
  final String? customMessage;
  final String? customLabel;

  EndsWith({
    required this.value,
    required this.attribute,
    required this.extra,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if (!value.endsWith(extra)) {
      return FV.buildMessage(customMessage ?? FV.endsWith, attribute, extra);
    }
    return null;
  }
}
