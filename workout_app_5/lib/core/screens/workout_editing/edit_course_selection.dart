

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/models/drawer_base_model.dart';

class EditCourseSelectionScreen extends StatelessWidget {
  static const id = 'edit_course_selection_screen';
  static const String title = 'Course Editing';


  @override
  Widget build(BuildContext context) {
    return DrawerBaseModel(
      appBarTitle: title,
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Center(
          child: CreatedCourse2ListView(),
        ),
      ),
    );
  }
}

class CreatedCourse2ListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutSelectionProvider>(
      builder: (context, workOutSelectionProvider, child) => ListView.builder(
        itemCount: workOutSelectionProvider.statelessEditingSelectionCourseCard.length,
        itemBuilder: (context, index) {
          return workOutSelectionProvider.statelessEditingSelectionCourseCard[index];
        },
      ),
    );
  }
}