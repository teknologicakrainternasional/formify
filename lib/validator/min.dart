import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if the length of a value meets or exceeds a specified minimum.
///
/// The `Min` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether the length of a value meets or exceeds a specified minimum length.
///
/// This rule checks if the length of the input `value` meets or exceeds the provided `number`.
/// If the length of the `value` is less than the `number`, an error message is generated.
class Min extends FormifyRule {
  /// The unique identifier for the `Min` validation rule.
  static const key = 'min';

  /// The minimum length required for the value.
  final num number;

  /// Creates an instance of the `Min` validation rule with a specified `number`.
  ///
  /// Parameters:
  /// - [number]: The minimum length required for the value.
  Min(this.number) : super.withKey(key);

  /// Gets the error message associated with the `Min` rule.
  @override
  String get message => FV.min;

  /// Validates whether the length of a value meets or exceeds the specified `number`.
  ///
  /// This method checks if the length of the input `value` meets or exceeds the provided `number`.
  /// If the length of the `value` is less than the `number`, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the length of the `value` is less than the specified `number`,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (value.length < number) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':number', number.toString());
          return message;
        });
      }
    }
    return null;
  }
}
