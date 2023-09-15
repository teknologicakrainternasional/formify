import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value starts with a specified pattern.
///
/// The `StartsWith` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value starts with a specified pattern.
///
/// This rule checks if the input `value` starts with the provided `pattern`.
/// If the `value` does not start with the `pattern`, an error message is generated.
class StartsWith extends FormifyRule {
  /// The unique identifier for the `StartsWith` validation rule.
  static const key = 'starts_with';

  /// The prefix pattern to check for at the beginning of the value.
  final String pattern;

  /// Creates an instance of the `StartsWith` validation rule with a specified `pattern`.
  ///
  /// Parameters:
  /// - [pattern]: The prefix pattern to check for at the beginning of the value.
  StartsWith(this.pattern) : super.withKey(key);

  /// Gets the error message associated with the `StartsWith` rule.
  @override
  String get message => FV.startsWith;

  /// Validates whether a value starts with the specified `pattern`.
  ///
  /// This method checks if the input `value` starts with the provided `pattern`.
  /// If the `value` does not start with the `pattern`, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` does not start with the `pattern`,
  /// or `null` if the `value` starts with the `pattern`.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (!value.startsWith(pattern)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':pattern', pattern);
          return message;
        });
      }
    }
    return null;
  }
}
