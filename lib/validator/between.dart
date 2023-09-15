import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Between implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;
  final num min;
  final num max;

  Between({
    required this.value,
    required this.attribute,
    required this.min,
    required this.max,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    final parsedValue = num.tryParse(value);
    if (parsedValue == null) {
      return VM.buildMessage(VM.numeric, attribute);
    }

    if (!((parsedValue >= min) && (parsedValue <= max))) {
      return VM.buildMessage(customMessage ?? VM.between, attribute, '$min,$max');
    }
    return null;
  }
}
