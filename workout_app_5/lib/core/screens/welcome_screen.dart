import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/create_workout_selection.dart';
import 'package:workout_app_5/core/screens/edit_workout_screen.dart';
import 'package:workout_app_5/core/screens/workout_selection.dart';
import 'package:workout_app_5/widgets/buttons/back_button.dart';
import 'package:workout_app_5/widgets/buttons/stateless_basic_button.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';
import 'package:workout_app_5/widgets/show_dialog/yes_no_alert_dialog.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    WorkOutSelectionProvider _workOutSelectionProvider =
        Provider.of<WorkOutSelectionProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => YesNoAlertDialog(
            titleText: 'Are you sure you want to exit the app',
            noButtonFunction: () {
              Navigator.pop(context,false);
            },
            yesButtonFunction: () {
              Navigator.pop(context,true);
            },
          ),
        );
      },
      child: SafeArea(
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
              Flexible(
                flex: 2,
                child: SizedBox(
                  height: 100.0,
                ),
              ),
              Flexible(
                flex: 6,
                child: StatelessBasicButton(
                  padding: 0.0,
                  borderRadius: 30.0,
                  elevation: 8.0,
                  width: 300.0,
                  height: 250.0,
                  text: 'Select Workout',
                  textStyle: kDefaultTextStyle,
                  onPressed: () async {
                    await _workOutSelectionProvider.launch();
                    Navigator.pushNamed(context, WorkOutSelectionScreen.id);
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 50.0,
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 6,
                    child: StatelessBasicButton(
                      padding: 12.0,
                      borderRadius: 30.0,
                      elevation: 8.0,
                      width: 200.0,
                      height: 150.0,
                      text: 'Create Workout',
                      textStyle: kDefaultTextStyle,
                      onPressed: () {
                        Navigator.pushNamed(context, CreateWorkOutSelection.id);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: StatelessBasicButton(
                      padding: 12.0,
                        borderRadius: 30.0,
                        elevation: 8.0,
                        width: 200.0,
                        height: 150.0,
                        text: 'Edit \nWorkout',
                        textStyle: kDefaultTextStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, EditWorkOutScreen.id);
                        },
                      ),
                  ),
                ],
              ),
              // Flexible(
              //   child: ReusableButton(
              //     borderRadius: 30.0,
              //     elevation: 8.0,
              //     padding: 0.0,
              //     width: 300.0,
              //     text: 'Querry All',
              //     textStyle: kDefaultTextStyle,
              //     onPressed: () async {
              //       List<Map<String, dynamic>> querryRows =
              //           await DatabaseManager.instance.querryAll();
              //       print(querryRows[0]);
              //       print(querryRows[5]);
              //       print(querryRows);
              //     },
              //   ),
              // ),
              // Flexible(
              //   child: ReusableButton(
              //     borderRadius: 30.0,
              //     elevation: 8.0,
              //     padding: 0.0,
              //     width: 300.0,
              //     text: 'Delete database',
              //     textStyle: kDefaultTextStyle,
              //     onPressed: () async {
              //       DatabaseManager.instance.deletedatabase();
              //     },
              //   ),
              // ),
              Flexible(
                flex: 2,
                child: SizedBox(
                  height: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
