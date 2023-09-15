import 'package:formify/validator/validator.dart';

/// An abstract class representing a validation rule for form field validation.
///
/// The `FormifyRule` class serves as a base class for creating custom validation rules
/// to validate form field values.
///
/// Validation rules must implement the `call` method, which returns an error message if
/// the validation fails or `null` if the validation succeeds.
///
/// Example usage:
///
/// ```dart
/// class MyCustomRule extends FormifyRule {
///   @override
///   String? call(String attribute, String value) {
///     // Implement your custom validation logic here.
///     // Return an error message if validation fails, or `null` if it succeeds.
///   }
/// }
/// ```
///
/// The `FormifyRule` class provides several built-in static factory methods for common
/// validation rules, such as required, numeric, integer, and more. You can also create
/// custom validation rules by extending this class.
///
/// Available built-in validation rules:
/// - `required`: Checks if the field value is not empty.
/// - `numeric`: Checks if the field value is numeric (integer or decimal).
/// - `integer`: Checks if the field value is an integer.
/// - `double`: Checks if the field value is a decimal number.
/// - `between`: Checks if the field value is within a specified numeric range.
/// - `min`: Checks if the field value is greater than or equal to a minimum value.
/// - `max`: Checks if the field value is less than or equal to a maximum value.
/// - `gt`: Checks if the field value is greater than a specified value.
/// - `gte`: Checks if the field value is greater than or equal to a specified value.
/// - `lt`: Checks if the field value is less than a specified value.
/// - `lte`: Checks if the field value is less than or equal to a specified value.
/// - `startsWith`: Checks if the field value starts with a specified pattern.
/// - `endsWith`: Checks if the field value ends with a specified pattern.
/// - `same`: Checks if the field value is the same as a specified pattern.
/// - `lowercase`: Checks if the field value is in lowercase.
/// - `uppercase`: Checks if the field value is in uppercase.
/// - `alphaNumeric`: Checks if the field value contains only letters and numbers.
/// - `email`: Checks if the field value is a valid email address.
/// - `ip`: Checks if the field value is a valid IP address.
/// - `url`: Checks if the field value is a valid URL.
/// - `inItems`: Checks if the field value is in a list of allowed items.
/// - `notInItems`: Checks if the field value is not in a list of disallowed items.
/// - `regEx`: Checks if the field value matches a specified regular expression pattern.
///
/// Custom validation rules can be created by extending this class and implementing
/// the `call` method.
abstract class FormifyRule {
  /// The unique key identifying the validation rule.
  final String ruleKey;

  /// The error message template for validation failures.
  String message = ':attribute is not valid';

  /// Creates an instance of the `FormifyRule` class with a generated unique key.
  FormifyRule() : ruleKey = DateTime.now().toString();

  /// Creates an instance of the `FormifyRule` class with a specified key.
  FormifyRule.withKey(this.ruleKey);

  /// Validates a field value and returns an error message if validation fails, or `null` if it succeeds.
  ///
  /// This method should be implemented in concrete validation rule classes to define the validation logic.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [value]: The value to be validated.
  ///
  /// Returns:
  /// A validation error message if the validation fails, or `null` if the validation succeeds.
  String? call(String attribute, String value);

  /// Builds a validation error message by replacing placeholders in the error message template.
  ///
  /// This method is used to construct an error message for validation failures.
  /// It replaces placeholders in the `message` template with actual values.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute being validated.
  /// - [input]: The input value that failed validation.
  /// - [onExtra]: A callback function to perform additional message modifications.
  ///
  /// Returns:
  /// The constructed validation error message.
  String buildMessage(
    String attribute,
    String input, {
    String Function(String)? onExtra,
  }) {
    message = message.replaceAll(":attribute", attribute);
    message = message.replaceAll(":input", input);
    if (onExtra != null) {
      message = onExtra(message);
    }
    return message;
  }

  /// Static factory method to create a required validation rule.
  static FormifyRule get required => Required();

  /// Static factory method to create a numeric validation rule.
  static FormifyRule get numeric => Numeric();

  /// Static factory method to create an integer validation rule.
  static FormifyRule get integer => Integer();

  /// Static factory method to create a double validation rule.
  static FormifyRule get double => Double();

  /// Static factory method to create a between validation rule.
  static FormifyRule between(num min, num max) => Between(min, max);

  /// Static factory method to create a min validation rule.
  static FormifyRule min(num number) => Min(number);

  /// Static factory method to create a max validation rule.
  static FormifyRule max(num number) => Max(number);

  /// Static factory method to create a gt validation rule.
  static FormifyRule gt(num number) => GreaterThan(number);

  /// Static factory method to create a gte validation rule.
  static FormifyRule gte(num number) => GreaterThanOrEqual(number);

  /// Static factory method to create a lt validation rule.
  static FormifyRule lt(num number) => LessThan(number);

  /// Static factory method to create a lte validation rule.
  static FormifyRule lte(num number) => LessThanOrEqual(number);

  /// Static factory method to create a startsWith validation rule.
  static FormifyRule startsWith(String pattern) => StartsWith(pattern);

  /// Static factory method to create a endsWith validation rule.
  static FormifyRule endsWith(String pattern) => EndsWith(pattern);

  /// Static factory method to create a same validation rule.
  static FormifyRule same(String pattern) => Same(pattern);

  /// Static factory method to create a lowercase validation rule.
  static FormifyRule get lowercase => LowerCase();

  /// Static factory method to create a uppercase validation rule.
  static FormifyRule get uppercase => UpperCase();

  /// Static factory method to create a alphaNumeric validation rule.
  static FormifyRule get alphaNumeric => AlphaNumeric();

  /// Static factory method to create a email validation rule.
  static FormifyRule get email => Email();

  /// Static factory method to create a ip validation rule.
  static FormifyRule get ip => IpAddress();

  /// Static factory method to create a url validation rule.
  static FormifyRule get url => URL();

  /// Static factory method to create a inItems validation rule.
  static FormifyRule inItems(List<String> items) => In(items);

  /// Static factory method to create a notInItems validation rule.
  static FormifyRule notInItems(List<String> items) => NotIn(items);

  /// Static factory method to create a regEx validation rule.
  static FormifyRule regEx(String pattern) => RegEx(pattern);
}
