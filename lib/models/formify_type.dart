import 'package:flutter/cupertino.dart';

enum FormifyType {
  text(),
  numeric(keyboardType: TextInputType.number),
  password(obscureText: true),
  email(keyboardType: TextInputType.emailAddress,),
  multiline(keyboardType: TextInputType.multiline),
  phone(keyboardType: TextInputType.phone),
  name(
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
  );

  const FormifyType({
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
  });

  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
}
