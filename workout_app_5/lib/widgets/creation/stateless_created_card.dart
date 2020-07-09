import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';

class StatelessCreatedCard extends StatelessWidget {
  final String workOutName;
  final String type;
  final String description;
  final int cardIndex;
  final TextEditingController textEditingController = TextEditingController();

  StatelessCreatedCard(
      {this.workOutName, this.type, this.cardIndex, this.description, Key key})
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
          onTap: () {
            print(cardIndex);
          },
        ),
      ),
    );
  }
}

class TextFieldForCreatedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Enter a number'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
    );
  }
}
