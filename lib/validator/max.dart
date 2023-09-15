import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if the length of a value does not exceed a specified maximum.
///
/// The `Max` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether the length of a value does not exceed a specified maximum length.
///
/// This rule checks if the length of the input `value` does not exceed the provided `number`.
/// If the length of the `value` exceeds the `number`, an error message is generated.
class Max extends FormifyRule {
  /// The unique identifier for the `Max` validation rule.
  static const key = 'max';

  /// The maximum length allowed for the value.
  final num number;

  /// Creates an instance of the `Max` validation rule with a specified `number`.
  ///
  /// Parameters:
  /// - [number]: The maximum length allowed for the value.
  Max(this.number) : super.withKey(key);

  /// Gets the error message associated with the `Max` rule.
  @override
  String get message => FV.max;

  /// Validates whether the length of a value does not exceed the specified `number`.
  ///
  /// This method checks if the length of the input `value` does not exceed the provided `number`.
  /// If the length of the `value` exceeds the `number`, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the length of the `value` exceeds the specified `number`,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (value.length > number) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':number', number.toString());
          return message;
        });
      }
    }
    return null;
  }
}
