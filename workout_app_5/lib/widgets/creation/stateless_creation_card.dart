import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';

class StatelessCreationCard extends StatelessWidget {
  final String workOutName;
  final String type;
  final String description;
  final int cardIndex;

  StatelessCreationCard({this.workOutName,this.type,this.cardIndex,this.description});

  
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseCreationProvider>(
      builder: (context, courseCreationProvider, child) =>
      Card(
        color: courseCreationProvider.activeList[cardIndex] ? Colors.grey[500] : Colors.white,
        child: ListTile(
          title: Text(workOutName),
          enabled: true,
          leading: Text(type),
          selected: false,
          onTap: () {
            print(courseCreationProvider.activeList[cardIndex]);
            courseCreationProvider.rebuild(cardIndex);
            print(courseCreationProvider.activeList[cardIndex]);
          },
        ),      
      ),
    );
  }
}