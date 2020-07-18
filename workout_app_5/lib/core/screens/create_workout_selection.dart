import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/creating/component_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_components_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_screen.dart';
import 'package:workout_app_5/enums/already_saved.dart';
import 'package:workout_app_5/widgets/buttons/stateless_basic_button.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';

class CreateWorkOutSelection extends StatelessWidget {
  static const id = 'create_workout_selection';
  @override
  Widget build(BuildContext context) {
    CourseCreationProvider _courseCreationProvider =
        Provider.of<CourseCreationProvider>(context, listen: false);
    ComponentCreationProvider _componentCreationProvider = Provider.of<ComponentCreationProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 100.0,
                ),
              ),
              Flexible(
                child: StatelessBasicButton(
                  borderRadius: 30.0,
                  elevation: 8.0,
                  padding: 8.0,
                  width: 250.0,
                  height: 200.0,
                  text: 'Create Workout Componenets',
                  textStyle: kDefaultTextStyle,
                  onPressed: () {
                    _componentCreationProvider.alreadySaved = SavedState.noChange;
                    Navigator.pushNamed(context, CreateComponenetsScreen.id);
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
                  text: 'Create Workout Course',
                  textStyle: kDefaultTextStyle,
                  onPressed: () async{
                    await _courseCreationProvider.launch(false);
                    Navigator.pushNamed(context, CreateCourseScreen.id);
                  },
                ),
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
      ),
    );
  }
}
