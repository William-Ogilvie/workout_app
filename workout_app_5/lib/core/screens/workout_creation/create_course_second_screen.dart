import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_screen.dart';
import 'package:workout_app_5/widgets/show_dialog/ok_alert_dialog.dart';
import 'package:workout_app_5/widgets/show_dialog/yes_no_alert_dialog.dart';

class CreateCourseSecondScreen extends StatelessWidget {
  static const id = 'created_course_second_screen';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numberTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    CourseCreationProvider courseCreationProvider =
        Provider.of<CourseCreationProvider>(context, listen: false);
    WorkOutSelectionProvider _workOutSelectionProvider =
        Provider.of<WorkOutSelectionProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  autofocus: false,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'A name is required';
                    }
                    return null;
                  },
                  initialValue: courseCreationProvider.editMode
                      ? courseCreationProvider.courseNameString
                      : '',
                  decoration:
                      InputDecoration(labelText: 'Enter a workout name'),
                  onSaved: (String val) {
                    courseCreationProvider.workOutName = val;
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  child: CreatedSelectedListView(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: RaisedButton(
                      color: Colors.grey[300],
                      child: Text('Get more components'),
                      onPressed: () async {
                        courseCreationProvider.editMode
                            ? await courseCreationProvider.launch(true)
                            : print('funny2');
                        courseCreationProvider.alreadyPushed = true;
                        courseCreationProvider.resetActiveList();
                        Navigator.pushNamed(context, CreateCourseScreen.id);
                      },
                    ),
                  ),
                  Consumer<CourseCreationProvider>(
                    builder: (context, courseCreationProvider, child) =>
                        Flexible(
                      child: RaisedButton(
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
                  ),
                  Flexible(
                    child: RaisedButton(
                      color: Colors.grey[300],
                      child: Text(
                          courseCreationProvider.editMode ? 'Save' : 'Submit'),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        if (courseCreationProvider.checkTimesNull()) {
                          showDialog(
                            context: context,
                            builder: (context) => OkAlertDialog(
                              titleText: 'Time values are required',
                              okButtonFunction: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          );
                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (context) => YesNoAlertDialog(
                            titleText: courseCreationProvider.editMode
                                ? 'Do you want to save?'
                                : 'Do you want to submit?',
                            noButtonFunction: () {
                              Navigator.pop(context);
                            },
                            yesButtonFunction: () {
                              _formKey.currentState.save();
                              courseCreationProvider.editMode
                                  ? courseCreationProvider.saveWorkOutCourse()
                                  : courseCreationProvider
                                      .submitWorkOutCourse();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  courseCreationProvider.editMode
                      ? Flexible(
                          child: RaisedButton(
                            color: Colors.grey[300],
                            child: Text('Delete'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return YesNoAlertDialog(
                                    titleText:
                                        'Are you sure you want to delete this component?',
                                    noButtonFunction: () {
                                      Navigator.pop(context);
                                    },
                                    yesButtonFunction: () async {
                                      await courseCreationProvider
                                          .deleteCourse();
                                      await _workOutSelectionProvider
                                          .launchEditMode();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        )
                      : Flexible(
                          child: SizedBox(
                            height: 0.0,
                            width: 0.0,
                          ),
                        ),
                ],
              ),
            ],
          ),
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
