import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a numeric value is greater than or equal to a specified number.
///
/// The `GreaterThanOrEqual` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a numeric value is greater than or equal to a specified number.
///
/// This rule checks if the input `value` is a valid numeric representation and whether it
/// is greater than or equal to the specified `number`. If the value is not a valid number
/// or is less than the specified number, an error message is generated.
class GreaterThanOrEqual extends FormifyRule {
  /// The unique identifier for the `GreaterThanOrEqual` validation rule.
  static const key = 'gte';

  /// The number that the value should be greater than or equal to.
  final num number;

  /// Creates an instance of the `GreaterThanOrEqual` validation rule.
  ///
  /// Parameters:
  /// - [number]: The number that the value should be greater than or equal to.
  GreaterThanOrEqual(this.number) : super.withKey(key);

  /// Gets the error message associated with the `GreaterThanOrEqual` rule.
  @override
  String get message => FV.gte;

  /// Validates whether a value is greater than or equal to the specified number.
  ///
  /// This method checks if the input `value` is a valid numeric representation and
  /// whether it is greater than or equal to the specified `number`. If the `value`
  /// is not a valid number or is less than the specified number, an error message
  /// is generated using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not greater than or equal to the specified `number`
  /// or is not a valid number, or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      final parsedValue = num.tryParse(value);
      if (parsedValue == null || !(parsedValue >= number)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':number', number.toString());
          return message;
        });
      }
    }
    return null;
  }
}
