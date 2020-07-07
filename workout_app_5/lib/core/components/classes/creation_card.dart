import 'package:flutter/material.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';
import 'package:workout_app_5/locator.dart';

class CreationCard {

  String workOutName;
  String type;
  int cardIndex;
  bool active;
  Card finishedCard;

  CreationCard({this.workOutName,this.type,this.active,this.cardIndex});

  CourseCreationProvider courseCreationProvider = locator<CourseCreationProvider>();

  void generateCard() {
    finishedCard = Card(
      color: active ? Colors.grey[400] : Colors.white,
      child: ListTile(
        title: Text(workOutName),
        enabled: true,
        leading: Text(type),
        selected: false,
        onTap: () {
          //active ? active = false : active = true;
          //generateCard();
          courseCreationProvider.rebuildList(cardIndex);
          print(cardIndex);
        },
      ),
    );
  }

}

