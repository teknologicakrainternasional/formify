import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is less than a specified number.
///
/// The `LessThan` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is less than a specified numeric value.
///
/// This rule checks if the input `value` is less than the provided `number`.
/// If the `value` is greater than or equal to the `number`, an error message is generated.
class LessThan extends FormifyRule {
  /// The unique identifier for the `LessThan` validation rule.
  static const key = 'lt';

  /// The numeric value to compare against.
  final num number;

  /// Creates an instance of the `LessThan` validation rule with a specified `number`.
  ///
  /// Parameters:
  /// - [number]: The numeric value to compare against.
  LessThan(this.number) : super.withKey(key);

  /// Gets the error message associated with the `LessThan` rule.
  @override
  String get message => FV.lt;

  /// Validates whether a value is less than the specified `number`.
  ///
  /// This method checks if the input `value` is less than the provided `number`.
  /// If the `value` is greater than or equal to the `number`, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not less than the specified `number`,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      final parsedValue = num.tryParse(value);
      if (parsedValue == null || !(parsedValue < number)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message.replaceAll(':number', number.toString());
          return message;
        });
      }
    }
    return null;
  }
}
