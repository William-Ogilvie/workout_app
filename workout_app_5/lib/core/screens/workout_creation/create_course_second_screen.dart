import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';

class CreateCourseSecondScreen extends StatelessWidget {
  static const id = 'created_course_second_screen';
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CreatedSelectedListView(),
      ),
    );
  }
}

class CreatedSelectedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseCreationProvider>(
      builder: (context, courseCreationProvider, child) => ListView.builder(
        itemCount: courseCreationProvider.statelessCreationCardSelected.length,
        itemBuilder: (context, index) {
          return courseCreationProvider.statelessCreationCardSelected[index];
        },
      ),
    );
  }
}