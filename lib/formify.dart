library formify;

class Formify{
  Map<String, String> get attributes => {};
  Map<String, String> get labels => {};
  Map<String, List<String>> get validators => {};
  Map<String, dynamic> get _values => {};
  Map<String, List<String>> get _errors => {};

  //ATTRIBUTE
  //TODO: attribute's form type

  //VALIDATOR
  //TODO: implement validator and add errors

  //LABEL
  String getLabel(String attribute){
    String label = labels[attribute]??'';
    if(label.isEmpty){
      label = attribute;
      label = label.replaceAll('_', ' ');
      label = _capitalize(label);
    }

    return label;
  }

  //VALUE
  setValue(String attribute, dynamic value){
    if(!attributes.containsKey(attribute)){
      return;
    }
    _values[attribute] = value;
  }

  dynamic getValue(String attribute){
    return _values[attribute];
  }

  //ERRORS
  addErrorMessage(String attribute, String message){
    if(!attributes.containsKey(attribute)){
      return;
    }
    List<String> messages = getErrorMessages(attribute)??[];
    messages.add(message);
    setErrorMessages(attribute, messages);
  }

  setErrorMessage(String attribute, String message){
    if(!attributes.containsKey(attribute)){
      return;
    }
    _errors[attribute] = [message];
  }

  setErrorMessages(String attribute, List<String> messages){
    if(!attributes.containsKey(attribute)){
      return;
    }
    _errors[attribute] = messages;
  }

  List<String>? getErrorMessages(String attribute){
    return _errors[attribute];
  }

  String? getErrorMessage(String attribute){
    List<String> errors = getErrorMessages(attribute)??[];
    if(errors.isNotEmpty){
      return errors[0];
    }
    return null;
  }

  clearErrorMessages(String attribute){
    _errors.remove(attribute);
  }

  clearAllErrorMessages(){
    _errors.clear();
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value.split(' ').map(_capitalizeFirst).join(' ');
  }

  String? _capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  //TODO: implement function to map
}
