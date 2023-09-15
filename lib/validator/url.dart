import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is a valid URL.
///
/// The `URL` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is a valid URL.
///
/// This rule checks if the input `value` matches the pattern of a valid URL.
/// If the `value` does not represent a valid URL, an error message is generated.
class URL extends FormifyRule {
  /// The unique identifier for the `URL` validation rule.
  static const key = 'url';

  /// Creates an instance of the `URL` validation rule.
  URL() : super.withKey(key);

  /// Gets the error message associated with the `URL` rule.
  @override
  String get message => FV.url;

  /// Validates whether a value is a valid URL.
  ///
  /// This method checks if the input `value` matches the pattern of a valid URL.
  /// If the `value` does not represent a valid URL, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` does not represent a valid URL,
  /// or `null` if the `value` is a valid URL.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      RegExp exp = RegExp(r"^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$");
      if (!exp.hasMatch(value)) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
