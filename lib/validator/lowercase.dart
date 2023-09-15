import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value contains only lowercase characters.
///
/// The `LowerCase` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value contains only lowercase characters.
///
/// This rule checks if the input `value` consists of lowercase letters only.
/// If the `value` contains any uppercase letters or other characters, an error message is generated.
class LowerCase extends FormifyRule {
  /// The unique identifier for the `LowerCase` validation rule.
  static const key = 'lowercase';

  /// Creates an instance of the `LowerCase` validation rule.
  LowerCase() : super.withKey(key);

  /// Gets the error message associated with the `LowerCase` rule.
  @override
  String get message => FV.lowercase;

  /// Validates whether a value contains only lowercase characters.
  ///
  /// This method checks if the input `value` consists of lowercase letters only
  /// by comparing it with a lowercase version of itself. If the `value` contains
  /// any uppercase letters or other characters, an error message is generated using
  /// the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` contains non-lowercase characters,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (value.toLowerCase() != value) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
