abstract class BaseRule {
  final String value;
  final String attribute;

  BaseRule(this.value, this.attribute);

  String? validate();
}
