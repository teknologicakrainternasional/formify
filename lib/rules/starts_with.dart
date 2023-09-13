import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class StartsWith implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String extra;
  final String? customMessage;
  final String? customLabel;

  StartsWith({
    required this.value,
    required this.attribute,
    required this.extra,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if (!value.startsWith(extra)) {
      return FV.buildMessage(customMessage ?? FV.startsWith, attribute, extra);
    }
    return null;
  }
}
