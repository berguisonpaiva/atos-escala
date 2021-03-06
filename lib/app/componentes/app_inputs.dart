import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInputs extends StatelessWidget {
  final String label;
  final Icon suffixIcon;
  final Function suffixIconOnPressed;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  const AppInputs({
    Key key,
    this.label,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.obscureText = false,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.obscureText,
      validator: this.validator,
      decoration: InputDecoration(
          labelText: this.label,
          suffixIcon: this.suffixIcon != null
              ? IconButton(
                  icon: this.suffixIcon,
                  onPressed: this.suffixIconOnPressed,
                )
              : null),
    );
  }
}
