import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  
  final ChangeNotifier model;
  final Function onTap;
  final String title;
  
  DrawerTile({
    this.onTap,
    this.title,
    this.model,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
        onTap: onTap,
        title: Text(
    title,
        ),
      );
  }
}
