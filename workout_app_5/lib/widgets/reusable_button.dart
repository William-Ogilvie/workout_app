import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton({
    @required this.padding,
    @required this.elevation,
    @required this.borderRadius,
    @required this.text,
    @required this.onPressed,
    @required this.textStyle,
    this.width,
    this.height,
  });

  final double padding;
  final double elevation;
  final double borderRadius;
  final String text;
  final Function onPressed;
  final TextStyle textStyle;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Material(
        elevation: elevation,
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
        child: MaterialButton(
          minWidth: width,
          height: height,
          onPressed: onPressed,
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}