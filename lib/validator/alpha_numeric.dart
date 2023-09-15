import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value contains only alphanumeric characters.
///
/// The `AlphaNumeric` class is a concrete implementation of the `FormifyRule` abstract
/// class. It is used to validate whether a string value contains only alphanumeric
/// characters (letters and digits).
///
/// This rule checks that the input value contains only characters from the ranges
/// 'a' to 'z' (both lowercase and uppercase) and '0' to '9'. If the value contains
/// any other characters, it is considered invalid, and an error message is generated.
class AlphaNumeric extends FormifyRule {
  /// The unique identifier for the `AlphaNumeric` validation rule.
  static const key = 'alpha_numeric';

  /// Creates an instance of the `AlphaNumeric` validation rule.
  AlphaNumeric() : super.withKey(key);

  /// Gets the error message associated with the `AlphaNumeric` rule.
  @override
  String get message => FV.alphaNum;

  /// Validates whether a value contains only alphanumeric characters.
  ///
  /// This method checks if the input `value` contains only characters from the ranges
  /// 'a' to 'z' (both lowercase and uppercase) and '0' to '9'. If the `value` contains
  /// any other characters, it is considered invalid, and an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` contains non-alphanumeric characters,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      RegExp exp = RegExp(r"^[a-zA-Z0-9]+$");
      if (!exp.hasMatch(value)) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
