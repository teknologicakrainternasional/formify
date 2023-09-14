import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class LessThan implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;
  final String extra;

  LessThan({
    required this.value,
    required this.attribute,
    required this.extra,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    final parsedValue = num.tryParse(value);
    final parsedExtra = num.tryParse(extra);
    if (parsedValue == null || parsedExtra == null) {
      return FV.buildMessage(FV.numeric, attribute);
    }

    if (!(parsedValue < parsedExtra)) {
      return FV.buildMessage(customMessage ?? FV.lt, attribute, extra);
    }
    return null;
  }
}
