import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final double elevation;
  final IconData iconData;
  final double borderRadius;

  SkipButton({
    @required this.onPressed,
    @required this.color,
    @required this.borderRadius,
    @required this.elevation,
    @required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 75,
      minWidth: 150,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: onPressed,
      child: Icon(
        iconData,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
