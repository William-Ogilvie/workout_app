import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_second_screen.dart';

class CreateCourseScreen extends StatelessWidget {
  static const id = 'create_course_screen';

  @override
  Widget build(BuildContext context) {
    // CourseCreationProvider _courseCreationProvider =
    //     Provider.of<CourseCreationProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Center(
            child: CreatedListView(),
          ),
        ),
        floatingActionButton: CreateFloatingActionButton(),
      ),
    );
  }
}

class CreatedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseCreationProvider>(
      builder: (context, courseCreationProvider, child) => ListView.builder(
        itemCount: courseCreationProvider.statelessCreationCardList.length,
        itemBuilder: (context, index) {
          return courseCreationProvider.statelessCreationCardList[index];
        },
      ),
    );
  }
}

class CreateFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseCreationProvider>(
      builder: (context, courseCreationProvider, child) => FloatingActionButton(
        onPressed: () {
          courseCreationProvider.createWithSelected();
          Navigator.pushNamed(context, CreateCourseSecondScreen.id);
        },
        elevation: 8.0,
        tooltip: 'Create Workout Course',
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
