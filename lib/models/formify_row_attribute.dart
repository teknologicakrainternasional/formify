import 'package:formify/models/_abstract.dart';
import 'package:formify/models/formify_attribute.dart';

class FormifyRowAttribute extends Attribute {
  final List<FormifyAttribute> attributes;

  /// Represents a row of form attributes in a Formify configuration.
  ///
  /// The `FormifyRowAttribute` class extends the `Attribute` class and is used
  /// to group multiple form attributes into a single row. It is designed for
  /// organizing form attributes horizontally in the user interface. This class
  /// takes a list of `FormifyAttribute` objects as its attributes, and all the
  /// attributes within the row share the same row identifier.
  ///
  /// Parameters:
  /// - [attributes]: A list of `FormifyAttribute` objects representing the form
  ///   attributes to be displayed in the row.
  FormifyRowAttribute(this.attributes) : super(Attribute.rowAttribute);
}
