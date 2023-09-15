import 'package:formify/validator/_fv.dart';
import 'package:formify/validator/formify_rule.dart';

/// A validation rule for checking if a value is not in a specified list of items.
///
/// The `NotIn` class is a concrete implementation of the `FormifyRule` abstract class.
/// It is used to validate whether a value is not present in a specified list of items.
///
/// This rule checks if the input `value` is not contained in the provided `items` list.
/// If the `value` is found in the `items` list, an error message is generated.
///
class NotIn extends FormifyRule {
  /// The unique identifier for the `NotIn` validation rule.
  static const key = 'not_in';

  /// The list of items to check for exclusion.
  final List<String> items;

  /// Creates an instance of the `NotIn` validation rule with a specified `items` list.
  ///
  /// Parameters:
  /// - [items]: The list of items to check for exclusion.
  NotIn(this.items) : super.withKey(key);

  /// Gets the error message associated with the `NotIn` rule.
  @override
  String get message => FV.notIn;

  /// Validates whether a value is not in the specified `items` list.
  ///
  /// This method checks if the input `value` is not contained in the provided `items` list.
  /// If the `value` is found in the `items` list, an error message is generated
  /// using the `buildMessage` method.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the `value` is found in the `items` list,
  /// or `null` if the `value` is valid.
  @override
  String? call(String attribute, String value) {
    if (value.isNotEmpty) {
      if (items.contains(value)) {
        return buildMessage(attribute, value, onExtra: (message) {
          message = message.replaceAll(':items', items.toString());
          return message;
        });
      }
    }
    return null;
  }
}
