import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_app_5/core/components/classes/creation_card.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';

class CourseCreationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mapList = [];
  int _index = 0;

  ScrollController scrollController;


  StatelessCreationCard _statelessCreationCard;
  List<StatelessCreationCard> _statelessCreationCardList = [];

  List<bool> _activeList = [];

  List<bool> get activeList => _activeList;

  set activeList(List<bool> val) {
    _activeList = val;
    notifyListeners();
  }
  


  List<StatelessCreationCard> get statelessCreationCardList => _statelessCreationCardList;

  set statelessCreationCardList(List<StatelessCreationCard> val) {
    _statelessCreationCardList = val;
    notifyListeners();
  }

  void launch() async {
    _mapList = await DatabaseManager.instance.querryAllComponenets();
    // print(_mapList);
    for (_index = 0; _index < _mapList.length; _index++) {
      _statelessCreationCard = StatelessCreationCard(
        workOutName: _mapList[_index].values.first.toString(),
        type: _mapList[_index].values.last,
        cardIndex: _index,
      );

      activeList.add(false);
      statelessCreationCardList.add(_statelessCreationCard);
    }
  }

  void rebuild(int index) {
    bool _tempBool;
    activeList.elementAt(index) ? _tempBool = false : _tempBool = true;
    activeList.removeAt(index);
    activeList.insert(index == 0 ? index : index--, _tempBool);
    print(activeList);


  //   _statelessCreationCard = statelessCreationCardList[index];
  //   statelessCreationCardList.removeAt(index);
  //   statelessCreationCardList.insert(index == 0 ? index : index--, _statelessCreationCard);
  }

  
}

