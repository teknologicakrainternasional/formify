import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is required (non-empty).
///
/// The `Required` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is required and non-empty.
///
/// This rule checks if the input `value` is empty (blank or null).
/// If the `value` is empty, an error message is generated.
class Required extends FormifyRule {
  /// The unique identifier for the `Required` validation rule.
  static const key = 'required';

  /// Creates an instance of the `Required` validation rule.
  Required() : super.withKey(key);

  /// Gets the error message associated with the `Required` rule.
  @override
  String get message => FV.required;

  /// Validates whether a value is required and non-empty.
  ///
  /// This method checks if the input `value` is empty (blank or null).
  /// If the `value` is empty, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is empty, or `null` if the `value` is not empty.
  @override
  String? call(String attribute, String value) {
    if (value.isEmpty) {
      return buildMessage(attribute, value);
    }
    return null;
  }
}
