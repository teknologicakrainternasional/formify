import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class GreaterThan implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;
  final num number;

  GreaterThan({
    required this.value,
    required this.attribute,
    required this.number,
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

    if (!(parsedValue > number)) {
      return VM.buildMessage(customMessage ?? VM.gt, attribute, '$number');
    }
    return null;
  }
}
