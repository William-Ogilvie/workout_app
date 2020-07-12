import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_screen.dart';

class StatelessEditingComponenetCard extends StatelessWidget {
  final String workOutName;
  final String type;
  final String description;
  final int cardIndex;
  final int databaseId;

  StatelessEditingComponenetCard({this.workOutName,this.type,this.cardIndex,this.description,this.databaseId});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<EditComponentsProvider>(
      builder: (context, editComponentsProvider, child) =>
      Card(
        color: Colors.white,
        child: ListTile(
          title: Text(workOutName),
          enabled: true,
          leading: Text(type),
          selected: false,
          onTap: () {
            editComponentsProvider.indexInUse = cardIndex;
            Navigator.pushNamed(context, EditComponentsScreen.id);
          },
        ),      
      ),
      
    );
  }
}

