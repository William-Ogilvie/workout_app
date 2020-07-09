import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/widgets/creation/stateless_created_card.dart';

class CreateCourseSecondScreen extends StatelessWidget {
  static const id = 'created_course_second_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: CreatedSelectedListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreatedSelectedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseCreationProvider>(
      builder: (context, courseCreationProvider, child) => ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          courseCreationProvider.reorderList(oldIndex, newIndex);
        },
        children: courseCreationProvider.statelessCreatedCardList,
      ),
    );
  }
}
