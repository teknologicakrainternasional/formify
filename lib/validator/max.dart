import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Max implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;
  final num number;

  Max({
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

    if (value.length > number) {
      return VM.buildMessage(customMessage ?? VM.max, attribute, '$number');
    }
    return null;
  }
}
