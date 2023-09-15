import 'package:flutter/cupertino.dart';

/// Enumeration of common form input types used in Formify.
///
/// The `FormifyType` enum defines a set of common form input types that can be
/// used to specify the characteristics of form fields in a Formify configuration.
/// Each enum value represents a different form field type and may include
/// additional configuration options such as the keyboard type, text capitalization,
/// and whether the input should be obscured (e.g., for passwords).
///
/// Enum Values:
/// - `text`: Represents a standard text input field.
/// - `numeric`: Represents a numeric input field (e.g., for numbers).
/// - `password`: Represents a password input field with obscured text.
/// - `email`: Represents an email input field with email-specific keyboard type.
/// - `multiline`: Represents a multiline text input field.
/// - `phone`: Represents a phone number input field with phone-specific keyboard type.
/// - `name`: Represents a name input field with name-specific keyboard type and
///   words text capitalization.
///
/// Properties:
/// - [keyboardType]: The keyboard type associated with the form field (optional).
/// - [textCapitalization]: The text capitalization style for the form field (optional).
/// - [obscureText]: Indicates whether the input text should be obscured (optional).
enum FormifyType {
  /// Represents a standard text input field.
  text(),

  /// Represents a numeric input field (e.g., for numbers).
  numeric(keyboardType: TextInputType.number),

  /// Represents a password input field with obscured text.
  password(obscureText: true),

  /// Represents an email input field with email-specific keyboard type.
  email(keyboardType: TextInputType.emailAddress),

  /// Represents a multiline text input field.
  multiline(keyboardType: TextInputType.multiline),

  /// Represents a multiline text input field.
  phone(keyboardType: TextInputType.phone),

  /// Represents a name input field with name-specific keyboard type and
  /// words text capitalization.
  name(
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
  );

  /// Constructor for `FormifyType` enum values.
  const FormifyType({
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
  });

  /// The keyboard type associated with the form field (optional).
  final TextInputType? keyboardType;

  /// The text capitalization style for the form field (optional).
  final TextCapitalization textCapitalization;

  /// Indicates whether the input text should be obscured (optional).
  final bool obscureText;
}
