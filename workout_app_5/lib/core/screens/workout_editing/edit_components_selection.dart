import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
import 'package:workout_app_5/core/screens/models/drawer_base_model.dart';

class EditComponentsSelectionScreen extends StatelessWidget {
  static const String id = 'edit_components_selection_screen';
  static const String title = 'Component Editing';

  @override
  Widget build(BuildContext context) {
    return DrawerBaseModel(
      appBarTitle: title,
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Center(
          child: CreatedComponentListView(),
        ),
      ),
    );
  }
}

class CreatedComponentListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditComponentsProvider>(
      builder: (context, _editComponentsProvider, child) => ListView.builder(
        itemCount:
            _editComponentsProvider.statelessEditingComponetCardList.length,
        itemBuilder: (context, index) {
          return _editComponentsProvider
              .statelessEditingComponetCardList[index];
        },
      ),
    );
  }
}
