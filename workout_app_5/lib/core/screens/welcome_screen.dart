import 'package:flutter/material.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/core/screens/create_workout_selection.dart';
import 'package:workout_app_5/core/screens/edit_workout_screen.dart';
import 'package:workout_app_5/core/screens/workout_selection.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  'Welcome to the Workout App',
                  style: kTitleTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 100.0,
              ),
            ),
            Expanded(
              flex: 6,
              child: ReusableButton(
                borderRadius: 30.0,
                elevation: 8.0,
                padding: 0.0,
                width: 300.0,
                text: 'Select Workout',
                textStyle: kDefaultTextStyle,
                onPressed: () {
                  Navigator.pushNamed(context, WorkOutSelectionScreen.id);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 50.0,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: ReusableButton(
                    borderRadius: 30.0,
                    elevation: 8.0,
                    padding: 8.0,
                    width: 300.0,
                    text: 'Create Workout',
                    textStyle: kDefaultTextStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, CreateWorkOutSelection.id);
                    },
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ReusableButton(
                    borderRadius: 30.0,
                    elevation: 8.0,
                    padding: 8.0,
                    width: 300.0,
                    text: 'Edit \nWorkout',
                    textStyle: kDefaultTextStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, EditWorkOutScreen.id);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ReusableButton(
                borderRadius: 30.0,
                elevation: 8.0,
                padding: 0.0,
                width: 300.0,
                text: 'Querry All',
                textStyle: kDefaultTextStyle,
                onPressed: () async {
                  List<Map<String, dynamic>> querryRows =
                      await DatabaseManager.instance.querryAll();
                  print(querryRows);
                },
              ),
            ),
            Expanded(
              child: ReusableButton(
                borderRadius: 30.0,
                elevation: 8.0,
                padding: 0.0,
                width: 300.0,
                text: 'Delete database',
                textStyle: kDefaultTextStyle,
                onPressed: () async {
                  DatabaseManager.instance.deletedatabase();
                },
              ),
            ),
            Expanded(
              flex: 2,
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
