import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is within a specified list of items.
///
/// The `In` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is contained within a specified list of items.
///
/// This rule checks if the input `value` is included in the provided `items` list.
/// If the `value` is not found within the list, an error message is generated.
class In extends FormifyRule {
  /// The unique identifier for the `In` validation rule.
  static const key = 'in';

  /// The list of items that the value should be contained within.
  final List<String> items;

  /// Creates an instance of the `In` validation rule.
  ///
  /// Parameters:
  /// - [items]: The list of items that the value should be contained within.
  In(this.items) : super.withKey(key);

  /// Gets the error message associated with the `In` rule.
  @override
  String get message => FV.inRes;

  /// Validates whether a value is within the specified list of items.
  ///
  /// This method checks if the input `value` is included in the provided `items` list.
  /// If the `value` is not found within the list, an error message is generated using
  /// the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is not within the specified `items` list,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (!items.contains(value)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message = message.replaceAll(':items', items.toString());
          return message;
        });
      }
    }
    return null;
  }
}
