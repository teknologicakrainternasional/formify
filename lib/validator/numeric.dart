import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is numeric.
///
/// The `Numeric` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is a numeric value.
///
/// This rule checks if the input `value` can be parsed as a numeric value.
/// If the `value` is not numeric, an error message is generated.
class Numeric extends FormifyRule {
  /// The unique identifier for the `Numeric` validation rule.
  static const key = 'numeric';

  /// Creates an instance of the `Numeric` validation rule.
  Numeric() : super.withKey(key);

  /// Gets the error message associated with the `Numeric` rule.
  @override
  String get message => FV.numeric;

  /// Validates whether a value is numeric.
  ///
  /// This method checks if the input `value` can be parsed as a numeric value.
  /// If the `value` is not numeric, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not a numeric value,
  /// or `null` if the `value` is a valid numeric value.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      final parsedValue = num.tryParse(value);
      if (parsedValue == null) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
