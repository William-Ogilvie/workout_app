import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/editing/edit_components_provider.dart';
import 'package:workout_app_5/core/screens/workout_editing/edit_components_selection.dart';
import 'package:workout_app_5/enums/already_saved.dart';
import 'package:workout_app_5/widgets/buttons/no_button.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                onWillPop: () async{
                  if (editComponentsProvider.alreadySaved == SavedState.change) {
                    return showDialog(
                      context: context,
                      builder: (context) => YesNoAlertDialog(
                        titleText: 'Are you sure you want to leave unsaved changes?',
                        noButtonFunction: () {
                          Navigator.pop(context,false);
                        },
                        yesButtonFunction: () {
                          Navigator.pop(context,true);
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
                        initialValue: editComponentsProvider
                            .statelessEditingComponetCardList[
                                editComponentsProvider.indexInUse]
                            .description,
                        //controller: workOutDescriptionController,
                        decoration:
                            InputDecoration(labelText: 'Workout Description'),
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

                          _formKey.currentState.save();

                          //editComponentsProvider.insertWorkOutComponent();
                          editComponentsProvider.saveWorkOutComponent();
                          // workOutDescriptionController.clear();
                          // workOutNameController.clear();

                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Workout Component Saved'),
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
                              return AlertDialog(
                                title: Text(
                                    'Are you sure you want to delete this component?'),
                                actions: <Widget>[
                                  NoButton(),
                                  FlatButton(
                                    child: Text('Yes'),
                                    onPressed: () async {
                                      await editComponentsProvider
                                          .deleteComponent();
                                      await editComponentsProvider.launch();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
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
