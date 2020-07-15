import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/component_creation_provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/enums/already_saved.dart';
import 'package:workout_app_5/widgets/show_dialog/yes_no_alert_dialog.dart';

class CreateComponenetsScreen extends StatelessWidget {
  static const id = 'create_component_screen';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController workOutNameController = TextEditingController();
  final TextEditingController workOutDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ComponentCreationProvider componentCreationProvider =
        Provider.of<ComponentCreationProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            onWillPop: () async {
              if (componentCreationProvider.alreadySaved == SavedState.change) {
                return showDialog(
                  context: context,
                  builder: (context) => YesNoAlertDialog(
                    titleText:
                        'Are you sure you want to leave unsaved changes?',
                    noButtonFunction: () {
                      Navigator.pop(context, false);
                    },
                    yesButtonFunction: () {
                      Navigator.pop(context, true);
                    },
                  ),
                );
              }
              return true;
            },
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    controller: workOutNameController,
                    decoration: InputDecoration(labelText: 'Workout Name'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'A workout name is required';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      componentCreationProvider.saveName(value);
                    },
                    onChanged: (String val) {
                      componentCreationProvider.alreadySaved =
                          SavedState.change;
                    },
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: workOutDescriptionController,
                    decoration:
                        InputDecoration(labelText: 'Workout Description'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'A workout desciption is required';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      componentCreationProvider.saveDescription(value);
                    },
                    onChanged: (String val) {
                      componentCreationProvider.alreadySaved =
                          SavedState.change;
                    },
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 100.0,
                    alignment: Alignment.center,
                    child: Consumer<ComponentCreationProvider>(
                      builder: (context, componentCreationProvider, child) =>
                          DropdownButton<String>(
                        value: componentCreationProvider.timeOrReps,
                        items: [
                          DropdownMenuItem(
                            child: Text('Reps'),
                            value: 'Reps',
                          ),
                          DropdownMenuItem(
                            child: Text('Time'),
                            value: 'Time',
                          ),
                        ],
                        onChanged: (value) {
                          componentCreationProvider.saveTimeOrReps(value);
                          componentCreationProvider.alreadySaved =
                              SavedState.change;
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 100.0,
                  ),
                ),
                Flexible(
                  child: RaisedButton(
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return YesNoAlertDialog(
                            titleText: 'Do you want to submit?',
                            noButtonFunction: () {
                              Navigator.pop(context, false);
                            },
                            yesButtonFunction: () {
                              _formKey.currentState.save();

                              componentCreationProvider
                                  .insertWorkOutComponent();

                              workOutDescriptionController.clear();

                              workOutNameController.clear();

                              Navigator.pop(context, true);
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
