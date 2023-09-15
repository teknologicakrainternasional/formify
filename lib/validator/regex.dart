import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value matches a specified regular expression pattern.
///
/// The `RegEx` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value matches a specified regular expression pattern.
///
/// This rule checks if the input `value` matches the provided `pattern` using a regular expression.
/// If the `value` does not match the `pattern`, an error message is generated.
class RegEx extends FormifyRule {
  /// The unique identifier for the `RegEx` validation rule.
  static const key = 'regex';

  /// The regular expression pattern to match against.
  final String pattern;

  /// Creates an instance of the `RegEx` validation rule with a specified `pattern`.
  ///
  /// Parameters:
  /// - [pattern]: The regular expression pattern to match against.
  RegEx(this.pattern) : super.withKey(key);

  /// Gets the error message associated with the `RegEx` rule.
  @override
  String get message => FV.regex;

  /// Gets the error message associated with the `RegEx` rule.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      RegExp exp = RegExp(pattern);
      if (!exp.hasMatch(value)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message = message.replaceAll(':pattern', pattern);
          return message;
        });
      }
    }
    return null;
  }
}
