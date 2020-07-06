import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';

class CreateCourseScreen extends StatelessWidget {
  static const id = 'create_course_screen';

  @override
  Widget build(BuildContext context) {
    CourseCreationProvider _courseCreationProvider =
        Provider.of<CourseCreationProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<CourseCreationProvider>(
                  builder: (context, courseCreationProvider, child) =>
                      ListView.builder(
                        itemCount: courseCreationProvider.creationCardList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 50.0,
                            width: 50.0,
                            child: Text(courseCreationProvider
                                .creationCardList[index].workOutName),
                          );
                        },
                      ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    _courseCreationProvider.launch();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
