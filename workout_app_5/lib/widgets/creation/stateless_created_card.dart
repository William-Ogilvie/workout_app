import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';

class StatelessCreatedCard extends StatelessWidget {
  final String workOutName;
  final String type;
  final String description;
  final int cardIndex;
  final int databaseId;
  final String timeNumber;
  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numberTextEditingController =
      TextEditingController();


  StatelessCreatedCard(
      {this.workOutName, this.type, this.cardIndex, this.description, Key key, this.timeNumber,this.databaseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseCreationProvider>(
      builder: (context, courseCreationProvider, child) => Card(
        color: Colors.white,
        child: ListTile(
          title: Text(workOutName),
          leading: Icon(Icons.format_align_justify),
          subtitle: Text(type),
          trailing: Text('${timeNumber == null ? '0' : timeNumber} ${type == 'Reps' ? type : 'Seconds'}'),
          onTap: () {
            courseCreationProvider.removeMode ? courseCreationProvider.removeCardFromCours(cardIndex)
            : showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'A number is required';
                                      }
                                      return null;
                                    },
                                    controller: numberTextEditingController,
                                    decoration: InputDecoration(
                                        labelText: 'Enter a number'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly,
                                    ],
                                    onSaved: (String val) {
                                      courseCreationProvider
                                          .assignNumberInput(val, cardIndex);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text('Submit'),
                                    onPressed: () {
                                      if (!_formKey.currentState.validate()) {
                                        return;
                                      }

                                      _formKey.currentState.save();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
            print(cardIndex);
          },
        ),
      ),
    );
  }
}






