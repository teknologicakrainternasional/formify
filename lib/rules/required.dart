import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class Required implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  Required({
    required this.value,
    required this.attribute,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return FV.buildMessage(customMessage ?? FV.required, attribute);
    }
    return null;
  }
}
