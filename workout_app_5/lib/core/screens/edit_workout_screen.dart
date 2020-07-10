import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_course_selection.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';

class EditWorkOutScreen extends StatelessWidget {
  static const id = 'edit_workout_screen';
  @override
  Widget build(BuildContext context) {
    WorkOutSelectionProvider _workOutSelectionProvider =
        Provider.of<WorkOutSelectionProvider>(context, listen: false);
    
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
                    text: 'Edit Workout Componenets',
                    textStyle: kDefaultTextStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, EditCourseSelectionScreen.id);
                    },
                  ),
                ),
                Expanded(
                  child: ReusableButton(
                    borderRadius: 30.0,
                    elevation: 8.0,
                    padding: 8.0,
                    width: 300.0,
                    text: 'Edit Workout Course',
                    textStyle: kDefaultTextStyle,
                    onPressed: () async{
                      await _workOutSelectionProvider.launchEditMode();
                      Navigator.pushNamed(context, EditCourseSelectionScreen.id);
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