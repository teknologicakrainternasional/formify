import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a numeric value is greater than a specified number.
///
/// The `GreaterThan` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a numeric value is greater than a specified number.
///
/// This rule checks if the input `value` is a valid numeric representation and whether it
/// is greater than the specified `number`. If the value is not a valid number or is not
/// greater than the specified number, an error message is generated.
class GreaterThan extends FormifyRule {
  /// The unique identifier for the `GreaterThan` validation rule.
  static const key = 'gt';

  /// The number that the value should be greater than.
  final num number;

  /// Creates an instance of the `GreaterThan` validation rule.
  ///
  /// Parameters:
  /// - [number]: The number that the value should be greater than.
  GreaterThan(this.number) : super.withKey(key);

  /// Gets the error message associated with the `GreaterThan` rule.
  @override
  String get message => FV.gt;

  /// Validates whether a value is greater than the specified number.
  ///
  /// This method checks if the input `value` is a valid numeric representation and
  /// whether it is greater than the specified `number`. If the `value` is not a valid
  /// number or is not greater than the specified number, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not greater than the specified `number`
  /// or is not a valid number, or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      final parsedValue = num.tryParse(value);
      if (parsedValue == null || !(parsedValue > number)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':number', number.toString());
          return message;
        });
      }
    }
    return null;
  }
}
