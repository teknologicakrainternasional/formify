import 'package:formify/models/_abstract.dart';
import 'package:formify/models/formify_type.dart';

class FormifyAttribute extends Attribute {
  final FormifyType type;

  /// Represents a form attribute in a Formify configuration.
  ///
  /// The `FormifyAttribute` class extends the `Attribute` class and is used to
  /// define a form attribute with additional information about its type. Each
  /// form attribute may have a specified type, which can be used to determine
  /// how it should be rendered in the user interface. The default type is
  /// `FormifyType.text`, indicating a text input field.
  ///
  /// Parameters:
  /// - [attribute]: The identifier of the form attribute.
  /// - [type]: The type of the form attribute, which determines its UI representation.
  FormifyAttribute(super.attribute, [this.type = FormifyType.text]);
}
