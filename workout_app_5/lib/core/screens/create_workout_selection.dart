import 'package:flutter/material.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_components_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_screen.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';

class CreateWorkOutSelection extends StatelessWidget {
  static const id = 'create_workout_selection';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100.0,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableButton(
                    borderRadius: 30.0,
                    elevation: 8.0,
                    padding: 8.0,
                    width: 300.0,
                    text: 'Create Workout Componenets',
                    textStyle: kDefaultTextStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, CreateComponenetsScreen.id);
                    },
                  ),
                ),
                Expanded(
                  child: ReusableButton(
                    borderRadius: 30.0,
                    elevation: 8.0,
                    padding: 8.0,
                    width: 300.0,
                    text: 'Create Workout Course',
                    textStyle: kDefaultTextStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, CreateCourseScreen.id);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
