


import 'package:flutter/material.dart';
import 'package:workout_app_5/core/screens/create_workout_selection.dart';
import 'package:workout_app_5/core/screens/edit_workout_screen.dart';
import 'package:workout_app_5/core/screens/welcome_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_components_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_second_screen.dart';
import 'package:workout_app_5/core/screens/workout_description.dart';
import 'package:workout_app_5/core/screens/workout_manager_screen.dart';
import 'package:workout_app_5/core/screens/workout_selection.dart';

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
    }
  }
}
