import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class Between implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;
  final String extra;

  Between({
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
    if (parsedValue == null) {
      return FV.buildMessage(FV.numeric, attribute);
    }

    final splitExtra = extra.split(",");
    final min = int.parse(splitExtra[0]);
    final max = int.parse(splitExtra[1]);
    if (!((parsedValue >= min) && (parsedValue >= max))) {
      return FV.buildMessage(customMessage ?? FV.between, attribute, extra);
    }
    return null;
  }
}
