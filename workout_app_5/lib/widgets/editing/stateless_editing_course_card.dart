import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_second_screen.dart';


class StatelessEditingSelectionCourseCard extends StatelessWidget {
  final String courseName;
  final int databaseId;

  StatelessEditingSelectionCourseCard({this.courseName,this.databaseId,Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    CourseCreationProvider courseCreationProvider =
        Provider.of<CourseCreationProvider>(context, listen: false);

    return Consumer<WorkOutSelectionProvider>(
      builder: (context, workOutSelectionProvider, child) =>
      Card(
        color: Colors.white,
        child: ListTile(
          title: Text('$courseName'),
          enabled: true,
          selected: false,
          onTap: () {
            courseCreationProvider.launchEditMode(databaseId, courseName);
            Navigator.pushNamed(context, CreateCourseSecondScreen.id);
          },
        ),      
      ),
    );
  }
}