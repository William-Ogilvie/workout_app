import 'package:flutter/material.dart';

class StatelessBasicButton extends StatelessWidget {
  StatelessBasicButton({
    @required this.elevation,
    @required this.borderRadius,
    @required this.text,
    @required this.onPressed,
    @required this.textStyle,
    @required this.width,
    @required this.height,
    @required this.padding,
  });

  final double elevation;
  final double borderRadius;
  final String text;
  final Function onPressed;
  final TextStyle textStyle;
  final double width;
  final double height;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
          child: MaterialButton(
        color: Colors.grey.shade300,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onPressed: onPressed,
        minWidth: width,
        height: height,
        child: Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

