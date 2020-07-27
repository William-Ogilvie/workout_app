import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/component_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_ui/workout_selection.dart';
import 'package:workout_app_5/locator.dart';
import 'core/components/provider/creating/course_creation_provider.dart';
import 'core/components/provider/selecting/workout_selection_provider.dart';
import 'core/components/route_generator.dart';
import 'package:animated_splash/animated_splash.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkOutManagerProviderV2>(
          create: (_) => WorkOutManagerProviderV2(),
        ),
        ChangeNotifierProvider<ComponentCreationProvider>(
          create: (_) => ComponentCreationProvider(),
        ),
        ChangeNotifierProvider<CourseCreationProvider>(
          create: (_) => CourseCreationProvider(),
        ),
        ChangeNotifierProvider<CourseCreationProvider>(
          create: (_) => CourseCreationProvider(),
        ),
        ChangeNotifierProvider<WorkOutSelectionProvider>(
          create: (_) => WorkOutSelectionProvider(),
        ),
        ChangeNotifierProvider<EditComponentsProvider>(
          create: (_) => EditComponentsProvider(),
        ),
      ],
      child: WorkOut(),
    ),
  );
}

class WorkOut extends StatelessWidget {
  final String _font = 'Roboto';
  final Map<int, Widget> output = {
    1: WorkOutSelectionScreen(),
  };

  @override
  Widget build(BuildContext context) {
    WorkOutSelectionProvider _workOutSelectionProvider =
        Provider.of<WorkOutSelectionProvider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        imagePath: 'images/playstore.png',
        home: WorkOutSelectionScreen(),
        duration: 2500,
        type: AnimatedSplashType.BackgroundProcess,
        customFunction: () {
          _workOutSelectionProvider.launch();
          return 1;
        },
        outputAndHome: output,
      ),
      //initialRoute: WorkOutSelectionScreen.id,
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
    );
  }
}

