

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/workout_selection.dart';
class EditCourseSelectionScreen extends StatelessWidget {
  static const id = 'edit_course_selection_screen';
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(12.0),
          child: Center(
            child: CreatedCourse2ListView(),
          ),
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