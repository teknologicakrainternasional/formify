import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is in uppercase.
///
/// The `UpperCase` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is entirely in uppercase.
///
/// This rule checks if the input `value` consists of uppercase letters only.
/// If the `value` contains any lowercase letters or is empty, an error message is generated.
class UpperCase extends FormifyRule {
  /// The unique identifier for the `UpperCase` validation rule.
  static const key = 'uppercase';

  /// Creates an instance of the `UpperCase` validation rule.
  UpperCase() : super.withKey(key);

  /// Gets the error message associated with the `UpperCase` rule.
  @override
  String get message => FV.uppercase;

  /// Validates whether a value is entirely in uppercase.
  ///
  /// This method checks if the input `value` consists of uppercase letters only.
  /// If the `value` contains any lowercase letters or is empty, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not entirely in uppercase or is empty,
  /// or `null` if the `value` is in uppercase.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (value.toUpperCase() != value) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
