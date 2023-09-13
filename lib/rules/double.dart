import 'package:formify/constants/fv.dart';
import 'package:formify/rules/_base_validator.dart';

class Double implements BaseValidator {
  @override
  final String value;
  @override
  final String attribute;
  final String? customMessage;
  final String? customLabel;

  Double({
    required this.value,
    required this.attribute,
    this.customMessage,
    this.customLabel,
  });

  @override
  String? validate() {
    if(value.isEmpty){
      return null;
    }
    final parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      return FV.buildMessage(customMessage ?? FV.double, attribute);
    }
    return null;
  }
}
