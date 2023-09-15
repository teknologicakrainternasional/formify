import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a numeric value falls within a specified range.
///
/// The `Between` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a numeric value falls within a specified range defined
/// by a minimum and maximum value (inclusive).
///
/// This rule checks if the input `value` is a valid numeric representation and whether it
/// falls within the specified range `[min, max]`. If the value is outside the range or
/// not a valid number, an error message is generated.
class Between extends FormifyRule {
  /// The unique identifier for the `Between` validation rule.
  static const key = 'between';

  /// The minimum value of the range (inclusive).
  final num min;

  /// The maximum value of the range (inclusive).
  final num max;

  /// Creates an instance of the `Between` validation rule.
  ///
  /// Parameters:
  /// - [min]: The minimum value of the range (inclusive).
  /// - [max]: The maximum value of the range (inclusive).
  Between(this.min, this.max) : super.withKey(key);

  /// Gets the error message associated with the `Between` rule.
  @override
  String get message => FV.between;

  /// Validates whether a numeric value falls within the specified range.
  ///
  /// This method checks if the input `value` is a valid numeric representation and
  /// whether it falls within the specified range `[min, max]`. If the `value` is
  /// outside the range or not a valid number, an error message is generated using
  /// the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is outside the specified range or
  /// not a valid number, or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      final parsedValue = num.tryParse(value);
      if (parsedValue == null ||
          !((parsedValue >= min) && (parsedValue <= max))) {
        return buildMessage(attribute, value, onExtra: (message) {
          message = message.replaceAll(":min", min.toString());
          message = message.replaceAll(":max", max.toString());
          return message;
        });
      }
    }
    return null;
  }
}
