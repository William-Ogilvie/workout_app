import 'package:flutter/material.dart';

class QuestionButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final double elevation;
  // final double minWidth;
  // final double height;

  QuestionButton(
      {@required this.onPressed,
      @required this.color,
      @required this.elevation,
      // @required this.height,
      // @required this.minWidth
      });
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      color: color,
      onPressed: onPressed,
      child: Text('?',style: TextStyle(fontSize: 16.0),),
      shape: CircleBorder(),
    );
  }
}