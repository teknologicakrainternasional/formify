import 'package:formify/models/_abstract.dart';
import 'package:formify/models/formify_attribute.dart';

class FormifyRowAttribute extends Attribute {
  final List<FormifyAttribute> attributes;

  FormifyRowAttribute(this.attributes) : super(Attribute.rowAttribute);
}
