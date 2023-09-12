class FR {
  FR._();

  static const required = "required";
  static const numeric = "numeric";
  static const integer = "integer";
  static const double = "double";

  static const _between = "between";
  static const _min = "min";
  static const _max = "max";
  static const _gt = "gt";
  static const _gte = "gte";
  static const _lt = "lt";
  static const _lte = "lte";

  static const _startsWith = "starts_with";
  static const _endsWith = "ends_with";
  static const _same = "same";

  static const _in = "in";
  static const _notIn = "not_in";
  static const _regex = "regex";

  static String between(num min, num max) => "$_between:$min,$max";

  static String min(num length) => "$_min:$length";

  static String max(num length) => "$_max:$length";

  static String gt(num number) => "$_gt:$number";

  static String gte(num number) => "$_gte:$number";

  static String lt(num number) => "$_lt:$number";

  static String lte(num number) => "$_lte:$number";

  static String startsWith(dynamic pattern) => "$_startsWith:$pattern";

  static String endsWith(dynamic pattern) => "$_endsWith:$pattern";

  static String same(dynamic other) => "$_same:$other";
  static const String lowercase = "lowercase";
  static const String uppercase = "uppercase";

  static const String alphaNumeric = "alpha_num";
  static const String email = "email";
  static const String ip = "ip";
  static const String url = "url";

  static String inItems(List<dynamic> items) =>
      "$_in:${items.toString().replaceAll(RegExp(r'[\]\[]'), "")}";

  static String notInItems(List<dynamic> items) =>
      "$_notIn:${items.toString().replaceAll(RegExp(r'[\]\[]'), "")}";

  static String regEx(String pattern) => "$_regex:$pattern";

  static const List<String> numericRules = [numeric, integer, double];
  static const List<String> sizeRules = [
    _between,
    _min,
    _max,
    _gt,
    _gte,
    _lt,
    _lte,
  ];
  static const List<String> stringRules = [
    _startsWith,
    _endsWith,
    lowercase,
    uppercase,
    _same
  ];
  static const List<String> implicitRules = [required];
  static const List<String> others = [
    alphaNumeric,
    _in,
    _notIn,
    _regex,
    email,
    ip,
    url,
  ];
  static const List<String> allRules = [
    ...numericRules,
    ...sizeRules,
    ...implicitRules,
    ...stringRules,
    ...others
  ];
}
