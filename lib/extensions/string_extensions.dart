import 'package:flutter/material.dart';
import 'package:formify/constants/ft.dart';
import 'package:formify/rules/rules.dart';

extension FormifyStringX on String {
  TextInputType get keyboardType {
    switch (this) {
      case FT.numeric:
        return TextInputType.number;
      case FT.password:
        return TextInputType.visiblePassword;
      case FT.email:
        return TextInputType.emailAddress;
      case FT.multiline:
        return TextInputType.multiline;
      case FT.phone:
        return TextInputType.phone;
      case FT.name:
        return TextInputType.name;
    }
    return TextInputType.text;
  }

  BaseValidator? getRuleValidator({
    required String attribute,
    required String value,
    required String rule,
    String? extra,
    String? customMessage,
  }) {
    switch (rule) {
      case "required":
        return Required(
            value: value, attribute: attribute, customMessage: customMessage);
      case "email":
        return Email(
            value: value, attribute: attribute, customMessage: customMessage);
      case "ip":
        return IpAddress(
            value: value, attribute: attribute, customMessage: customMessage);
      case "url":
        return URL(
            value: value, attribute: attribute, customMessage: customMessage);
      case "starts_with":
        return StartsWith(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "same":
        return Same(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "ends_with":
        return EndsWith(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "between":
        return Between(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "max":
        return Max(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "min":
        return Min(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "in":
        return In(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "not_in":
        return NotIn(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "gt":
        return GreaterThan(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "gte":
        return GreaterThanOrEqual(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "lt":
        return LessThan(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "lte":
        return LessThanOrEqual(
            value: value,
            extra: extra!,
            attribute: attribute,
            customMessage: customMessage);
      case "double":
        return Double(
            value: value, attribute: attribute, customMessage: customMessage);
      case "interger":
        return Integer(
            value: value, attribute: attribute, customMessage: customMessage);

      case "numeric":
        return Numeric(
            value: value, attribute: attribute, customMessage: customMessage);
      case "alpha_num":
        return Integer(
            value: value, attribute: attribute, customMessage: customMessage);
      case "lowercase":
        return LowerCase(
            value: value, attribute: attribute, customMessage: customMessage);

      case "uppercase":
        return UpperCase(
            value: value, attribute: attribute, customMessage: customMessage);
      case "regex":
        return RegEx(
            value: value,
            attribute: attribute,
            customMessage: customMessage,
            extra: extra!);
      default:
        return null;
    }
  }
}
