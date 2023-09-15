import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/_abstract.dart';

class NotIn implements Validator {
  final String value;
  final String attribute;
  final String? customMessage;
  final List<String> items;

  NotIn({
    required this.value,
    required this.attribute,
    required this.items,
    this.customMessage,
  });

  @override
  String? validate() {
    if (value.isEmpty) {
      return null;
    }
    if (items.contains(value)) {
      return VM.buildMessage(
          customMessage ?? VM.notIn, attribute, items.toString());
    }
    return null;
  }
}
