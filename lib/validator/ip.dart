import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is a valid IP address.
///
/// The `IpAddress` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value represents a valid IP address.
///
/// This rule checks if the input `value` matches the pattern of a valid IP address.
/// If the `value` does not match the pattern, an error message is generated.
class IpAddress extends FormifyRule {
  /// The unique identifier for the `IpAddress` validation rule.
  static const key = 'ip';

  /// Creates an instance of the `IpAddress` validation rule.
  IpAddress() : super.withKey(key);

  /// Gets the error message associated with the `IpAddress` rule.
  @override
  String get message => FV.ip;

  /// Validates whether a value represents a valid IP address.
  ///
  /// This method checks if the input `value` matches the pattern of a valid IP address.
  /// If the `value` does not match the pattern, an error message is generated using
  /// the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` does not represent a valid IP address,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      RegExp exp = RegExp(
          r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$",
          caseSensitive: false,
          multiLine: false);
      if (!exp.hasMatch(value)) {
        return buildMessage(attribute, value);
      }
    }
    return null;
  }
}
