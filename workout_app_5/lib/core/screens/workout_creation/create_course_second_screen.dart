import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_screen.dart';
import 'package:workout_app_5/widgets/creation/stateless_created_card.dart';

class CreateCourseSecondScreen extends StatelessWidget {
  static const id = 'created_course_second_screen';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numberTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    CourseCreationProvider courseCreationProvider =
        Provider.of<CourseCreationProvider>(context, listen: false);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.grey[300],
                  child: Text('Get more components'),
                  onPressed: () {
                    courseCreationProvider.alreadyPushed = true;
                    courseCreationProvider.resetActiveList();
                    Navigator.pushNamed(context, CreateCourseScreen.id);
                  },
                ),
                Consumer<CourseCreationProvider>(
                  builder: (context, courseCreationProvider, child) =>
                      RaisedButton(
                    color: courseCreationProvider.removeMode
                        ? Colors.red[400]
                        : Colors.grey[300],
                    child: Text('Remove'),
                    onPressed: () {
                      courseCreationProvider.removeMode
                          ? courseCreationProvider.removeMode = false
                          : courseCreationProvider.removeMode = true;
                    },
                  ),
                ),
                RaisedButton(
                  color: Colors.grey[300],
                  child: Text('Submit'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'A name is required';
                                          }
                                          return null;
                                        },
                                        controller: numberTextEditingController,
                                        decoration: InputDecoration(
                                            labelText: 'Enter a workout name'),
                                        onSaved: (String val) {
                                          courseCreationProvider.workOutName =
                                              val;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text('Submit'),
                                        onPressed: () {
                                          if (!_formKey.currentState
                                              .validate()) {
                                            return;
                                          }

                                          _formKey.currentState.save();
                                          courseCreationProvider
                                              .submitWorkOutCourse();
                                          print('WorkOut Submitted!!!!');
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    //Navigator.pop(context);
                  },
                ),
              ],
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
