import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class UpperCase implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  UpperCase({
    required this.value,
    required this.attribute,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    if (value.toUpperCase() != value) {
      return FV.buildMessage(customMessage ?? FV.uppercase, attribute);
    }
    return null;
  }
}
