import 'package:flutter/material.dart';

class StatelessBackButton extends StatelessWidget {
  StatelessBackButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: CircleBorder(),
      child: Icon(
        Icons.arrow_back,
      ),
      onPressed: onPressed,
    );
  }
}
