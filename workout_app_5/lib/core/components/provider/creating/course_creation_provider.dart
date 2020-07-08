import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/widgets/creation/stateless_creation_card.dart';

class CourseCreationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mapList = [];
  int _index = 0;

  ScrollController scrollController;

  List<StatelessCreationCard> _statelessCreationCardSelected = [];

  List<StatelessCreationCard> get statelessCreationCardSelected => _statelessCreationCardSelected;

  set statelessCreationCardSelected(List<StatelessCreationCard> val) {
    _statelessCreationCardSelected = val;
    notifyListeners();
  }

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
    
    for (_index = 0; _index < activeList.length; _index++) {
      activeList[_index] ? statelessCreationCardSelected.add(statelessCreationCardList[_index]) : print('funny'); 
    }
    
  }

}

