import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  BackButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: MaterialButton(
        child: Icon(
          Icons.arrow_back,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

