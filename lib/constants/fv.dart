class FV {
  FV._();

  static String required = "@field is required";
  static String min = "@field is should be at least @extra characters";
  static String same = "@field is is not the same as @extra";
  static String max = "@field is cannot be more than @extra characters";
  static String endsWith = "@field must end with @extra";
  static String lowercase = "@field must all be lowercase";
  static String uppercase = "@field must all be uppercase";
  static String startsWith = "@field must start with @extra";
  static String contain = "@field must contains one of your words";
  static String email = "@field must be a valid email";
  static String numeric = "@field must be a valid number";
  static String integer = "@field must be integer";
  static String double = "@field must be double";
  static String alphaNum = "@field must contains only letters and numbers";
  static String between = "@field must be between @extra";
  static String contains = "@field must contains one of your worlds";
  static String haveAlpha = "@field must have alpha in it";
  static String ip = "@field must be a valid IP";
  static String inRes = "@field must be in [@extra]";
  static String notIn = "@field must be not be in @extra";
  static String lt = "@field must be less than @extra";
  static String gt = "@field must be less than @extra";
  static String lte = "@field must be less than or equal to @extra";
  static String gte = "@field must be greater than or equal to @extra";
  static String url = "@field must be a valid url";
  static String regex = "@field is not valid";

  static String buildMessage(
    String message,
    String attribute, [
    String? extra,
  ]) {
    message = message.replaceAll("@field", attribute);
    if (extra != null) {
      return message.replaceAll("@extra", extra);
    }
    return message;
  }
}
