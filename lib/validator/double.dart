import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class Double implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;

  Double({
    required this.value,
    required this.attribute,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    final parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      return VM.buildMessage(customMessage ?? VM.double, attribute);
    }
    return null;
  }
}
