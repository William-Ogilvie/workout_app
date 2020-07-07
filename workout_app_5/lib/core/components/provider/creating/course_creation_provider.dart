

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_app_5/core/components/classes/creation_card.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';

class CourseCreationProvider extends ChangeNotifier {

  List<Map<String, dynamic>> _mapList = [];
  List<CreationCard> _creationCardList = [];
  List<Card> _creationCompletedCardList = [];
  int _index = 0;


  List<CreationCard> get creationCardList => _creationCardList;

  set creationCardList (List<CreationCard> val) {
    _creationCardList = val;
    notifyListeners();
  }

  List<Card> get creationCompletedCardList => _creationCompletedCardList;

  set creationCompletedCardList (List<Card> val) {
    _creationCompletedCardList = val;
    notifyListeners();
  }

  void launch() async {
    _mapList = await DatabaseManager.instance.querryAllComponenets();
    // print(_mapList);
    for(_index = 0; _index < _mapList.length; _index++) {
      CreationCard _tempCard = CreationCard();
      _tempCard.workOutName = _mapList[_index].values.first.toString();
      _tempCard.type = _mapList[_index].values.last;
      _tempCard.active = false;
      _tempCard.cardIndex = _index;
      creationCardList.add(_tempCard);
      print(creationCardList[_index].workOutName);
      print(creationCardList[_index].type);
      
      _tempCard.generateCard();
      
      creationCompletedCardList.add(_tempCard.finishedCard);
      
      
    }  
  }

  void rebuildList(int index) {
    CreationCard _tempCard = CreationCard();
    creationCardList[index].active = true;
    _tempCard = creationCardList[index];
    _tempCard.generateCard();

    creationCompletedCardList.insert(index, _tempCard.finishedCard);
  }

}

// void rebuildList(int index) {
//         _tempCard.active = true;
//         _tempCard.generateCard();
//         creationCompletedCardList.insert(index, _tempCard.finishedCard);
//       }