import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/widgets/creation/stateless_created_card.dart';
import 'package:workout_app_5/widgets/creation/stateless_creation_card.dart';

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

  List<StatelessCreationCard> get statelessCreationCardList =>
      _statelessCreationCardList;

  set statelessCreationCardList(List<StatelessCreationCard> val) {
    _statelessCreationCardList = val;
    notifyListeners();
  }

  List<StatelessCreatedCard> _statelessCreatedCardList = [];

  List<StatelessCreatedCard> get statelessCreatedCardList =>
      _statelessCreatedCardList;

  set statelessCreatedCardList(List<StatelessCreatedCard> val) {
    _statelessCreatedCardList = val;
    notifyListeners();
  }

  bool _alreadyPushed = false;

  bool get alreadyPushed => _alreadyPushed;

  set alreadyPushed(bool val) {
    _alreadyPushed = val;
    notifyListeners();
  } 

  bool _removeMode = false;

  bool get removeMode => _removeMode;

  set removeMode(bool val) {
    _removeMode = val;
    notifyListeners();
  } 

  void launch() async {
    _mapList = await DatabaseManager.instance.querryAllComponenets();
    // print(_mapList);
    for (_index = 0; _index < _mapList.length; _index++) {
      _statelessCreationCard = StatelessCreationCard(
        workOutName: _mapList[_index].values.elementAt(0).toString(),
        type: _mapList[_index].values.elementAt(2),
        cardIndex: _index,
        description: _mapList[_index].values.elementAt(1),
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

    statelessCreationCardList = statelessCreationCardList;
  }

  void createWithSelected() {
    int _newCardIndex = 0;
    for (_index = 0; _index < activeList.length; _index++) {
      if (activeList[_index] == true) {
        StatelessCreatedCard tempCard = StatelessCreatedCard(
          cardIndex: _newCardIndex,
          description: _statelessCreationCardList[_index].description,
          workOutName: _statelessCreationCardList[_index].workOutName,
          type: _statelessCreationCardList[_index].type,
          key: UniqueKey(),
        );
        _newCardIndex++;
        statelessCreatedCardList.add(tempCard);
      }
    }
  }

  void reorderList(int oldIndex, int newIndex) {
    StatelessCreatedCard tempCard = StatelessCreatedCard(
      cardIndex: oldIndex > newIndex ? newIndex : newIndex--,
      description: statelessCreatedCardList[oldIndex].description,
      workOutName: statelessCreatedCardList[oldIndex].workOutName,
      type: statelessCreatedCardList[oldIndex].type,
      timeNumber: statelessCreatedCardList[oldIndex].timeNumber,
      key: statelessCreatedCardList[oldIndex].key,
    );
    print(oldIndex);
    print(newIndex);

    print(statelessCreatedCardList);
    statelessCreatedCardList.removeAt(oldIndex);

    oldIndex > newIndex
        ? statelessCreatedCardList.insert(newIndex, tempCard)
        : newIndex >= statelessCreatedCardList.length
            ? statelessCreatedCardList.add(tempCard)
            : statelessCreatedCardList.insert(newIndex--, tempCard);
    print(statelessCreatedCardList);
    rebuildCreatedCardList();
  }

  void rebuildCreatedCardList() {
    for (int index = 0; index < statelessCreatedCardList.length; index++) {
      StatelessCreatedCard tempCard = StatelessCreatedCard(
        cardIndex: index,
        description: statelessCreatedCardList[index].description,
        workOutName: statelessCreatedCardList[index].workOutName,
        type: statelessCreatedCardList[index].type,
        timeNumber: statelessCreatedCardList[index].timeNumber,
        key: statelessCreatedCardList[index].key,
      );
      statelessCreatedCardList.removeAt(index);
      statelessCreatedCardList.insert(index, tempCard);
    }
    statelessCreatedCardList = statelessCreatedCardList;
  }

  void resetActiveList() {
    for (int index = 0; index < activeList.length; index++) {
      activeList[index] = false;
    }
  }

  void assignNumberInput(String val, int index) {
    StatelessCreatedCard tempCard = StatelessCreatedCard(
      cardIndex: index,
      description: statelessCreatedCardList[index].description,
      workOutName: statelessCreatedCardList[index].workOutName,
      type: statelessCreatedCardList[index].type,
      timeNumber: val,
      key: statelessCreatedCardList[index].key,
    );
    statelessCreatedCardList.removeAt(index);
    statelessCreatedCardList.insert(index, tempCard);

    statelessCreatedCardList = statelessCreatedCardList;
  }

  void removeCardFromCours(int index) {
    statelessCreatedCardList.removeAt(index);
    rebuildCreatedCardList();
  }
}
