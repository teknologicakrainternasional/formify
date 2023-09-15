import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value matches another value (equality check).
///
/// The `Same` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value matches another specified value (equality check).
///
/// This rule checks if the input `value` is equal to a specified `pattern`.
/// If the `value` is not equal to the `pattern`, an error message is generated.
class Same extends FormifyRule {
  /// The unique identifier for the `Same` validation rule.
  static const key = 'same';

  /// The value to compare for equality.
  final String pattern;

  /// Creates an instance of the `Same` validation rule with a specified `pattern`.
  ///
  /// Parameters:
  /// - [pattern]: The value to compare for equality.
  Same(this.pattern) : super.withKey(key);

  /// Gets the error message associated with the `Same` rule.
  @override
  String get message => FV.same;

  /// Validates whether a value matches a specified `pattern` (equality check).
  ///
  /// This method checks if the input `value` is equal to the specified `pattern`.
  /// If the `value` is not equal to the `pattern`, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not equal to the `pattern`,
  /// or `null` if the `value` is equal to the `pattern`.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (value != pattern) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':pattern', pattern);
          return message;
        });
      }
    }
    return null;
  }
}
