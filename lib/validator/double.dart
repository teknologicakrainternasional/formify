import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is a valid double.
///
/// The `Double` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a string value can be successfully parsed into a
/// double (floating-point) number.
///
/// This rule checks if the input `value` is a valid double representation. If the
/// `value` cannot be parsed as a double, an error message is generated.
class Double extends FormifyRule {
  /// The unique identifier for the `Double` validation rule.
  static const key = 'double';

  /// Creates an instance of the `Double` validation rule.
  Double() : super.withKey(key);

  /// Gets the error message associated with the `Double` rule.
  @override
  String get message => FV.double;

  /// Validates whether a value is a valid double representation.
  ///
  /// This method checks if the input `value` can be successfully parsed as a double
  /// (floating-point) number. If the `value` cannot be parsed as a double, an error
  /// message is generated using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` cannot be parsed as a double,
  /// or `null` if the `value` is a valid double.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      final parsedValue = double.tryParse(value);
      if (parsedValue == null) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
