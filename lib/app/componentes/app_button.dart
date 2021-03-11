import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double heitght;
  final Color buttonColor;
  final String labelText;
  final TextStyle textStyle;
  final Color labelColor;
  final double labelSize;
  final Function onPressed;

  const AppButton({
    Key key,
    this.width,
    this.heitght,
    this.buttonColor,
    this.labelText,
    this.textStyle,
    this.labelColor,
    this.labelSize,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heitght,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: buttonColor,
        child: Text(
          labelText,
          style: textStyle ?? TextStyle(fontSize: labelSize, color: labelColor),
        ),
      ),
    );
  }
}
