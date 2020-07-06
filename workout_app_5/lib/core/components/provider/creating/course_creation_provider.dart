

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_app_5/core/components/classes/creation_card.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';

class CourseCreationProvider extends ChangeNotifier {

  List<Map<String, dynamic>> _mapList = [];
  List<CreationCard> _creationCardList = [];
  int _index = 0;

  List<CreationCard> get creationCardList => _creationCardList;

  set creationCardList (List<CreationCard> val) {
    _creationCardList = val;
    notifyListeners();
  }

  void launch() async {
    _mapList = await DatabaseManager.instance.querryAllComponenets();
    // print(_mapList);
    for(_index = 0; _index < _mapList.length; _index++) {
      CreationCard _tempCard = CreationCard();
      _tempCard.workOutName = _mapList[_index].values.first.toString();
      _tempCard.type = _mapList[_index].values.last;
      creationCardList.add(_tempCard);
      print(creationCardList[_index].workOutName);
      print(creationCardList[_index].type);
    }
  }

  

}