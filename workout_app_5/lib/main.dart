import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/component_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
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
  final String _font = 'Roboto';

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
        ChangeNotifierProvider.value(
          value: EditComponentsProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData.light().copyWith(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            caption: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            headline1: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            headline2: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            headline3: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            headline4: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            headline5: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            headline6: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            subtitle1: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            subtitle2: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
            overline: TextStyle(
              color: Colors.black,
              fontFamily: _font,
            ),
          ),
        ),
      ),
    );
  }
}
