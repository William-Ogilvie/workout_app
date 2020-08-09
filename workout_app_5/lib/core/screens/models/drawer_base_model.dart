import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/component_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_components_screen.dart';
import 'package:workout_app_5/core/screens/workout_creation/create_course_screen.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_screen.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_selection.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_course_selection.dart';
import 'package:workout_app_5/core/screens/workout_ui/workout_selection.dart';
import 'package:workout_app_5/enums/already_saved.dart';
import 'package:workout_app_5/widgets/ui/drawer_tile.dart';

class DrawerBaseModel extends StatelessWidget {
  final Widget body;
  final Widget floatingActionButton;
  final String appBarTitle;

  DrawerBaseModel({this.body, this.floatingActionButton, this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    // WorkOutManagerProviderV2 workOutManagerProviderV2 =
    //     Provider.of<WorkOutManagerProviderV2>(context, listen: false);
    WorkOutSelectionProvider _workOutSelectionProvider =
        Provider.of<WorkOutSelectionProvider>(context, listen: false);
    ComponentCreationProvider _componentCreationProvider =
        Provider.of<ComponentCreationProvider>(context, listen: false);
    CourseCreationProvider _courseCreationProvider =
        Provider.of<CourseCreationProvider>(context, listen: false);
    EditComponentsProvider _editComponentsProvider =
        Provider.of<EditComponentsProvider>(context, listen: false);

    final List<Widget> _listViewList = [
      DrawerTile(
        model: CourseCreationProvider(),
        title: 'Select',
        onTap: () async {
          await _workOutSelectionProvider.launch();
          Navigator.pushNamed(context, WorkOutSelectionScreen.id);
        },
      ),
      DrawerTile(
        title: 'Create Components',
        onTap: () {
          _componentCreationProvider.alreadySaved = SavedState.noChange;
          Navigator.pushNamed(context, CreateComponenetsScreen.id);
        },
      ),
      DrawerTile(
        title: 'Create Courses',
        onTap: () async {
          await _courseCreationProvider.launch(false);
          Navigator.pushNamed(context, CreateCourseScreen.id);
        },
      ),
      DrawerTile(
        title: 'Edit Components',
        onTap: () async {
          await _editComponentsProvider.launch();
          Navigator.pushNamed(context, EditComponentsSelectionScreen.id);
        },
      ),
      DrawerTile(
        title: 'Edit Courses',
        onTap: () async {
          await _workOutSelectionProvider.launchEditMode();
          Navigator.pushNamed(context, EditCourseSelectionScreen.id);
        },
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitle,
            textAlign: TextAlign.center,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: _listViewList,
          ),
        ),
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
