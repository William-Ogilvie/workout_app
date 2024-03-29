




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/screens/create_workout_selection.dart';
import 'package:workout_app_5/core/screens/edit_workout_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_components_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_second_screen.dart';
import 'package:workout_app_5/core/screens/workout_play/workout_description.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_screen.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_selection.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_course_selection.dart';
import 'package:workout_app_5/core/screens/workout_play/workout_manager_screen.dart';
import 'package:workout_app_5/core/screens/workout_ui/workout_selection.dart';
import 'package:workout_app_5/core/screens/workout_ui/welcome_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case WelcomeScreen.id:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case WorkOutSelectionScreen.id:
        return MaterialPageRoute(
            builder: (context) => WorkOutSelectionScreen());
      case WorkOutDescriptionScreen.id:
        return MaterialPageRoute(
            builder: (context) => WorkOutDescriptionScreen());
      case WorkOutManagerScreen.id:
        return MaterialPageRoute(
          builder: (context) => WorkOutManagerScreen(),
        );
      case EditWorkOutScreen.id:
        return MaterialPageRoute(
          builder: (context) => EditWorkOutScreen(),
        );
      case CreateWorkOutSelection.id:
        return MaterialPageRoute(
          builder: (context) => CreateWorkOutSelection(),
        );
      case CreateComponenetsScreen.id:
        return MaterialPageRoute(
          builder: (context) => CreateComponenetsScreen(),
        );
      case CreateCourseScreen.id:
        return MaterialPageRoute(
          builder: (context) => CreateCourseScreen(),
        );
      case CreateCourseSecondScreen.id:
        return MaterialPageRoute(
          builder: (context) => CreateCourseSecondScreen(),
        );
      case EditCourseSelectionScreen.id:
        return MaterialPageRoute(
          builder: (context) => EditCourseSelectionScreen(),
        );
      case EditComponentsSelectionScreen.id:
        return MaterialPageRoute(
          builder: (context) => EditComponentsSelectionScreen(),
        );
      case EditComponentsScreen.id:
        return MaterialPageRoute(
          builder: (context) => EditComponentsScreen(),
        );
    }
    return null;
  }
}
