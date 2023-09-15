class FV {
  FV._();

  static String required = ":attribute is required";
  static String min = ":attribute is should be at least :number characters";
  static String same = ":attribute is is not the same as :pattern";
  static String max = ":attribute is cannot be more than :number characters";
  static String endsWith = ":attribute must end with :pattern";
  static String lowercase = ":attribute must all be lowercase";
  static String uppercase = ":attribute must all be uppercase";
  static String startsWith = ":attribute must start with :pattern";
  static String contain = ":attribute must contains one of your words";
  static String email = ":attribute must be a valid email";
  static String numeric = ":attribute must be a valid number";
  static String integer = ":attribute must be integer";
  static String double = ":attribute must be double";
  static String alphaNum = ":attribute must contains only letters and numbers";
  static String between = ":attribute is not between :min - :max";
  static String contains = ":attribute must contains one of your worlds";
  static String haveAlpha = ":attribute must have alpha in it";
  static String ip = ":attribute must be a valid IP";
  static String inRes = ":attribute must be in [:items]";
  static String notIn = ":attribute must be not be in [:items]";
  static String lt = ":attribute must be less than :number";
  static String gt = ":attribute must be less than :number";
  static String lte = ":attribute must be less than or equal to :number";
  static String gte = ":attribute must be greater than or equal to :number";
  static String url = ":attribute must be a valid url";
  static String regex = ":attribute is not valid";
}
