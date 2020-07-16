import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_selection.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_course_selection.dart';
import 'package:workout_app_5/widgets/buttons/stateless_basic_button.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';

class EditWorkOutScreen extends StatelessWidget {
  static const id = 'edit_workout_screen';
  @override
  Widget build(BuildContext context) {
    WorkOutSelectionProvider _workOutSelectionProvider =
        Provider.of<WorkOutSelectionProvider>(context, listen: false);
    EditComponentsProvider _editComponentsProvider = Provider.of<EditComponentsProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 100.0,
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: StatelessBasicButton(
                    borderRadius: 30.0,
                    elevation: 8.0,
                    padding: 8.0,
                    width: 250.0,
                    height: 200.0,
                    text: 'Edit Workout Componenets',
                    textStyle: kDefaultTextStyle,
                    onPressed: () async{
                      await _editComponentsProvider.launch();
                      Navigator.pushNamed(context, EditComponentsSelectionScreen.id);
                    },
                  ),
                ),
                Flexible(
                  child: StatelessBasicButton(
                    borderRadius: 30.0,
                    elevation: 8.0,
                    padding: 8.0,
                    width: 250.0,
                    height: 200.0,
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
            Flexible(
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