class VM {
  VM._();

  static String required = "@attribute is required";
  static String min = "@attribute is should be at least @extra characters";
  static String same = "@attribute is is not the same as @extra";
  static String max = "@attribute is cannot be more than @extra characters";
  static String endsWith = "@attribute must end with @extra";
  static String lowercase = "@attribute must all be lowercase";
  static String uppercase = "@attribute must all be uppercase";
  static String startsWith = "@attribute must start with @extra";
  static String contain = "@attribute must contains one of your words";
  static String email = "@attribute must be a valid email";
  static String numeric = "@attribute must be a valid number";
  static String integer = "@attribute must be integer";
  static String double = "@attribute must be double";
  static String alphaNum = "@attribute must contains only letters and numbers";
  static String between = "@attribute must be between @extra";
  static String contains = "@attribute must contains one of your worlds";
  static String haveAlpha = "@attribute must have alpha in it";
  static String ip = "@attribute must be a valid IP";
  static String inRes = "@attribute must be in [@extra]";
  static String notIn = "@attribute must be not be in @extra";
  static String lt = "@attribute must be less than @extra";
  static String gt = "@attribute must be less than @extra";
  static String lte = "@attribute must be less than or equal to @extra";
  static String gte = "@attribute must be greater than or equal to @extra";
  static String url = "@attribute must be a valid url";
  static String regex = "@attribute is not valid";

  static String buildMessage(
    String message,
    String attribute, [
    String? extra,
  ]) {
    message = message.replaceAll("@attribute", attribute);
    if (extra != null) {
      return message.replaceAll("@extra", extra);
    }
    return message;
  }
}
