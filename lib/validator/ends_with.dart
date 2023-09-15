import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a string value ends with a specified pattern.
///
/// The `EndsWith` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a string value ends with a specific pattern.
///
/// This rule checks if the input `value` ends with the specified `pattern`. If the `value`
/// does not end with the pattern, an error message is generated.
class EndsWith extends FormifyRule {
  /// The unique identifier for the `EndsWith` validation rule.
  static const key = 'end_with';

  /// The pattern that the value should end with.
  final String pattern;

  /// Creates an instance of the `EndsWith` validation rule.
  ///
  /// Parameters:
  /// - [pattern]: The pattern that the value should end with.
  EndsWith(this.pattern) : super.withKey(key);

  /// Gets the error message associated with the `EndsWith` rule.
  @override
  String get message => FV.endsWith;

  /// Validates whether a value ends with the specified pattern.
  ///
  /// This method checks if the input `value` ends with the specified `pattern`. If
  /// the `value` does not end with the pattern, an error message is generated using
  /// the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` does not end with the specified `pattern`,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (!value.endsWith(pattern)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':pattern', pattern);
          return message;
        });
      }
    }
    return null;
  }
}
