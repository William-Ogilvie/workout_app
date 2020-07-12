import 'package:flutter/material.dart';

class NoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('No'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}