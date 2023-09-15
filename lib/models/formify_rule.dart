import 'package:formify/validator/_abstract.dart';
import 'package:formify/validator/alpha_numeric.dart';
import 'package:formify/validator/between.dart';
import 'package:formify/validator/double.dart';
import 'package:formify/validator/email.dart';
import 'package:formify/validator/ends_with.dart';
import 'package:formify/validator/gt.dart';
import 'package:formify/validator/gte.dart';
import 'package:formify/validator/in.dart';
import 'package:formify/validator/integer.dart';
import 'package:formify/validator/ip.dart';
import 'package:formify/validator/lowercase.dart';
import 'package:formify/validator/lt.dart';
import 'package:formify/validator/lte.dart';
import 'package:formify/validator/max.dart';
import 'package:formify/validator/min.dart';
import 'package:formify/validator/not_in.dart';
import 'package:formify/validator/numeric.dart';
import 'package:formify/validator/regex.dart';
import 'package:formify/validator/required.dart';
import 'package:formify/validator/same.dart';
import 'package:formify/validator/starts_with.dart';
import 'package:formify/validator/uppercase.dart';
import 'package:formify/validator/url.dart';

class FormifyRule<T, S> {

  final FormifyRuleEnum rule;
  final T extra1;
  final S extra2;

  FormifyRule._(this.rule, this.extra1, this.extra2);

  static FormifyRule get required => FormifyRule._(FormifyRuleEnum.required, null, null);
  static FormifyRule get numeric => FormifyRule._(FormifyRuleEnum.numeric, null, null);
  static FormifyRule get integer => FormifyRule._(FormifyRuleEnum.integer, null, null);
  static FormifyRule get double => FormifyRule._(FormifyRuleEnum.double, null, null);

  static FormifyRule between(num min, num max) => FormifyRule._(FormifyRuleEnum.between, min, max);
  static FormifyRule min(num number) => FormifyRule._(FormifyRuleEnum.min, number, null);
  static FormifyRule max(num number) => FormifyRule._(FormifyRuleEnum.max, number, null);
  static FormifyRule gt(num number) => FormifyRule._(FormifyRuleEnum.gt, number, null);
  static FormifyRule gte(num number) => FormifyRule._(FormifyRuleEnum.gte, number, null);
  static FormifyRule lt(num number) => FormifyRule._(FormifyRuleEnum.lt, number, null);
  static FormifyRule lte(num number) => FormifyRule._(FormifyRuleEnum.lte, number, null);

  static FormifyRule startsWith(String pattern) => FormifyRule._(FormifyRuleEnum.startsWith, pattern, null);
  static FormifyRule endsWith(String pattern) => FormifyRule._(FormifyRuleEnum.endsWith, pattern, null);
  static FormifyRule same(String pattern) => FormifyRule._(FormifyRuleEnum.same, pattern, null);
  static FormifyRule get lowercase => FormifyRule._(FormifyRuleEnum.lowercase, null, null);
  static FormifyRule get uppercase => FormifyRule._(FormifyRuleEnum.uppercase, null, null);

  static FormifyRule get alphaNumeric => FormifyRule._(FormifyRuleEnum.alphaNumeric, null, null);
  static FormifyRule get email => FormifyRule._(FormifyRuleEnum.email, null, null);
  static FormifyRule get ip => FormifyRule._(FormifyRuleEnum.ip, null, null);
  static FormifyRule get url => FormifyRule._(FormifyRuleEnum.url, null, null);
  static FormifyRule inItems(List<String> items) => FormifyRule._(FormifyRuleEnum.inItems, items, null);
  static FormifyRule notInItems(List<String> items) => FormifyRule._(FormifyRuleEnum.notInItems, items, null);
  static FormifyRule regEx(String pattern) => FormifyRule._(FormifyRuleEnum.regEx, pattern, null);

  String? validate(String attribute, String value, [String? customMessage]){
    return getValidator(attribute, value, customMessage)?.validate();
  }
}

enum FormifyRuleEnum{
  required,

  numeric,
  integer,
  double,

  between,
  min,
  max,
  gt,
  gte,
  lt,
  lte,

  startsWith,
  endsWith,
  same,
  lowercase,
  uppercase,

  alphaNumeric,
  email,
  ip,
  url,
  inItems,
  notInItems,
  regEx;
}

extension FormifyRuleX on FormifyRule{
  Validator? getValidator(String attribute, String value, [String? customMessage]){
    switch(rule){
      case FormifyRuleEnum.required:
        return Required(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.numeric:
        return Numeric(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.integer:
        return Integer(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.double:
        return Double(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.between:
        return Between(value: value, attribute: attribute, min: extra1, max: extra2, customMessage: customMessage,);
      case FormifyRuleEnum.min:
        return Min(value: value, attribute: attribute, number: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.max:
        return Max(value: value, attribute: attribute, number: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.gt:
        return GreaterThan(value: value, attribute: attribute, number: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.gte:
        return GreaterThanOrEqual(value: value, attribute: attribute, number: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.lt:
        return LessThan(value: value, attribute: attribute, number: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.lte:
        return LessThanOrEqual(value: value, attribute: attribute, number: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.startsWith:
        return StartsWith(value: value, attribute: attribute, pattern: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.endsWith:
        return EndsWith(value: value, attribute: attribute, pattern: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.same:
        return Same(value: value, attribute: attribute, pattern: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.lowercase:
        return LowerCase(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.uppercase:
        return UpperCase(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.alphaNumeric:
        return AlphaNumeric(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.email:
        return Email(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.ip:
        return IpAddress(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.url:
        return URL(value: value, attribute: attribute, customMessage: customMessage,);
      case FormifyRuleEnum.inItems:
        return In(value: value, attribute: attribute, items: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.notInItems:
        return NotIn(value: value, attribute: attribute, items: extra1, customMessage: customMessage,);
      case FormifyRuleEnum.regEx:
        return RegEx(value: value, attribute: attribute, pattern: extra1, customMessage: customMessage,);
    }
  }
}