import 'package:flutter/material.dart';

class YesNoAlertDialog extends StatelessWidget {
  final String titleText;
  final Function noButtonFunction;
  final Function yesButtonFunction;

  YesNoAlertDialog({this.titleText,this.noButtonFunction,this.yesButtonFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: noButtonFunction,
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: yesButtonFunction,
        ),
      ],
    );
  }
}