/// Abstract base class for defining form attributes in Formify.
///
/// The `Attribute` class serves as an abstract base class for defining form
/// attributes within a Formify configuration. It provides a common structure
/// for all form attributes by including an `attribute` identifier. This identifier
/// uniquely identifies the form attribute within the configuration.
///
/// Subclasses of `Attribute` may provide additional functionality or properties
/// to customize the behavior and appearance of form attributes.
///
/// Properties:
/// - [attribute]: The unique identifier of the form attribute.
abstract class Attribute {
  static const rowAttribute = '_row';

  /// The unique identifier of the form attribute.
  final String attribute;

  /// Parameters:
  /// - [attribute]: The unique identifier of the form attribute.
  Attribute(this.attribute);
}
