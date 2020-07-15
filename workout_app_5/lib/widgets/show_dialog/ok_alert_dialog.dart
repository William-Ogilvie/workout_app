import 'package:flutter/material.dart';

class OkAlertDialog extends StatelessWidget {
  final String titleText;
  final Function okButtonFunction;

  OkAlertDialog({this.titleText,this.okButtonFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: okButtonFunction,
        ),
      ],
    );
  }
}