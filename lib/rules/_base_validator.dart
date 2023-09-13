abstract class BaseValidator {
  final String value;
  final String attribute;

  BaseValidator(this.value, this.attribute);

  String? validate();
}
