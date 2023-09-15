import 'package:formify/models/_abstract.dart';
import 'package:formify/models/formify_type.dart';

class FormifyAttribute extends Attribute {
  final FormifyType type;

  FormifyAttribute(super.attribute, [this.type = FormifyType.text]);
}
