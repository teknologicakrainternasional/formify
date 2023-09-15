import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is a valid integer.
///
/// The `Integer` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is a valid integer.
///
/// This rule checks if the input `value` is a valid integer by attempting to parse it.
/// If the `value` is not a valid integer, an error message is generated.
class Integer extends FormifyRule {
  /// The unique identifier for the `Integer` validation rule.
  static const key = 'integer';

  /// Creates an instance of the `Integer` validation rule.
  Integer() : super.withKey(key);

  /// Gets the error message associated with the `Integer` rule.
  @override
  String get message => FV.integer;

  /// Validates whether a value is a valid integer.
  ///
  /// This method checks if the input `value` is a valid integer by attempting to parse it.
  /// If the `value` is not a valid integer, an error message is generated using the
  /// `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not a valid integer, or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      final parsedValue = int.tryParse(value);
      if (parsedValue == null) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
