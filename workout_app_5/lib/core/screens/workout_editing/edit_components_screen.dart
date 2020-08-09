import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
import 'package:workout_app_5/core/screens/models/drawer_base_model.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_selection.dart';
import 'package:workout_app_5/enums/already_saved.dart';
import 'package:workout_app_5/widgets/buttons/no_button.dart';
import 'package:workout_app_5/widgets/show_dialog/ok_alert_dialog.dart';
import 'package:workout_app_5/widgets/show_dialog/yes_no_alert_dialog.dart';

class EditComponentsScreen extends StatelessWidget {
  static const id = 'edit_components_screen';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController workOutNameController = TextEditingController();
  final TextEditingController workOutDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    EditComponentsProvider editComponentsProvider =
        Provider.of<EditComponentsProvider>(context, listen: false);
    
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          onWillPop: () async {
            if (editComponentsProvider.alreadySaved == SavedState.change) {
              return showDialog(
                context: context,
                builder: (context) => YesNoAlertDialog(
                  titleText: 'Are you sure you want to leave unsaved changes?',
                  noButtonFunction: () {
                    Navigator.pop(context, false);
                  },
                  yesButtonFunction: () {
                    Navigator.pop(context, true);
                  },
                ),
              );
            }
            await editComponentsProvider.launch();
            return true;
          },
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  initialValue: editComponentsProvider
                      .statelessEditingComponetCardList[
                          editComponentsProvider.indexInUse]
                      .workOutName,
                  //controller: workOutNameController,
                  decoration: InputDecoration(labelText: 'Workout Name'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'A workout name is required';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    editComponentsProvider.saveName(value);
                  },
                  onChanged: (String val) {
                    editComponentsProvider.alreadySaved = SavedState.change;
                  },
                ),
              ),
              Flexible(
                child: TextFormField(
                  maxLines: null,
                  initialValue: editComponentsProvider
                      .statelessEditingComponetCardList[
                          editComponentsProvider.indexInUse]
                      .description,
                  //controller: workOutDescriptionController,
                  decoration: InputDecoration(labelText: 'Workout Description'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'A workout desciption is required';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    editComponentsProvider.saveDescription(value);
                  },
                  onChanged: (String val) {
                    editComponentsProvider.alreadySaved = SavedState.change;
                  },
                ),
              ),
              Flexible(
                child: Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: Consumer<EditComponentsProvider>(
                    builder: (context, editComponentsProvider, child) =>
                        DropdownButton<String>(
                      value: editComponentsProvider.timeOrReps,
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
                        editComponentsProvider.alreadySaved = SavedState.change;
                        editComponentsProvider.saveTimeOrReps(value);
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

                    //editComponentsProvider.insertWorkOutComponent();

                    // workOutDescriptionController.clear();
                    // workOutNameController.clear();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return YesNoAlertDialog(
                          titleText: 'Are you sure you want to save?',
                          noButtonFunction: () {
                            Navigator.pop(context, false);
                          },
                          yesButtonFunction: () {
                            _formKey.currentState.save();
                            editComponentsProvider.saveWorkOutComponent();
                            Navigator.pop(context, true);
                            editComponentsProvider.launch();

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OkAlertDialog(
                                  titleText: 'Workout component saved',
                                  okButtonFunction: () {
                                    Navigator.pop(context, true);
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: RaisedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return YesNoAlertDialog(
                          titleText:
                              'Are you sure you want to delete this component?',
                          noButtonFunction: () {
                            Navigator.pop(context);
                          },
                          yesButtonFunction: () async {
                            await editComponentsProvider.deleteComponent();
                            await editComponentsProvider.launch();
                            Navigator.pop(context);

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return OkAlertDialog(
                                    titleText: 'Workout component deleted',
                                    okButtonFunction: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete',
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
    );
  }
}

//  showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       content: Stack(
//                         children: <Widget>[
//                           Text('Workout Component Saved'),
//                         ],
//                       ),
//                       actions: <Widget>[
//                         Text('ok'),
//                       ],
//                     );
//                   },
//                 );
