import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/component_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/locator.dart';
import 'core/components/provider/creating/course_creation_provider.dart';
import 'core/components/provider/selecting/workout_selection_provider.dart';
import 'core/components/route_generator.dart';
import 'core/screens/welcome_screen.dart';


void main() {
  setupLocator();
  runApp(WorkOut());
}

class WorkOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: WorkOutManagerProviderV2(),
        ),
        ChangeNotifierProvider.value(
          value: ComponentCreationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CourseCreationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CourseCreationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: WorkOutSelectionProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
