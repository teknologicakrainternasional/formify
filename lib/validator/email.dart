import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is a valid email address.
///
/// The `Email` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a string value represents a valid email address
/// based on a regular expression pattern.
///
/// This rule checks if the input `value` matches a valid email address pattern. If
/// the `value` does not match the pattern, an error message is generated.
class Email extends FormifyRule {
  /// The unique identifier for the `Email` validation rule.
  static const key = 'email';

  /// Creates an instance of the `Email` validation rule.
  Email() : super.withKey(key);

  /// Gets the error message associated with the `Email` rule.
  @override
  String get message => FV.email;

  /// Validates whether a value is a valid email address.
  ///
  /// This method checks if the input `value` matches a valid email address pattern
  /// using a regular expression. If the `value` does not match the pattern, an error
  /// message is generated using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` does not represent a valid email address,
  /// or `null` if the `value` is a valid email address.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      RegExp exp = RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
          caseSensitive: false);
      if (!exp.hasMatch(value)) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
