import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/enums/already_saved.dart';
import 'package:workout_app_5/widgets/editing/stateless_editing_components.dart';

class EditComponentsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mapList = [];

  List<StatelessEditingComponenetCard> _statelessEditingComponetCardList = [];

  List<StatelessEditingComponenetCard> get statelessEditingComponetCardList => _statelessEditingComponetCardList;

  set statelessEditingComponetCardList(List<StatelessEditingComponenetCard> val) {
    _statelessEditingComponetCardList = val;
    notifyListeners();
  }

  int _indexInUse = 0;

  int get indexInUse => _indexInUse;

  set indexInUse(int val) {
    _indexInUse = val;
    notifyListeners();
  }  

  String _workOutName;
  String _workOutDescription;
  String _timeOrReps = 'Reps';


  String get timeOrReps => _timeOrReps;

  set timeOrReps(String val) {
    _timeOrReps = val;
    notifyListeners();
  }

  SavedState _alreadySaved = SavedState.noChange;

  SavedState get alreadySaved => _alreadySaved;

  set alreadySaved(SavedState val) {
    _alreadySaved = val;
    notifyListeners();
  }

  

  void saveName(String name) {
    _workOutName = name;
  }

  void saveDescription(String desc) {
    _workOutDescription = desc;
  }

  void saveTimeOrReps(String type) {
    timeOrReps = type;
  }

  void launch() async{
    alreadySaved = SavedState.noChange;
    statelessEditingComponetCardList = [];
    _mapList = await DatabaseManager.instance.querryAllComponenets();
    
    for (int _index = 0; _index < _mapList.length; _index++) {
      StatelessEditingComponenetCard _statelessEditingComponenetCard = StatelessEditingComponenetCard(
        workOutName: _mapList[_index].values.elementAt(0).toString(),
        type: _mapList[_index].values.elementAt(2),
        cardIndex: _index,
        description: _mapList[_index].values.elementAt(1),
        databaseId: _mapList[_index].values.elementAt(3),
      );

      statelessEditingComponetCardList.add(_statelessEditingComponenetCard);
    }
    statelessEditingComponetCardList = statelessEditingComponetCardList;
  }

  void saveWorkOutComponent() async{
    print(_workOutName);
    print(_workOutDescription);
    print(timeOrReps);
    //await DatabaseManager.instance.insertComponent(_workOutName, _workOutDescription, timeOrReps);
    await DatabaseManager.instance.updateComponent(_workOutName, _workOutDescription, timeOrReps, statelessEditingComponetCardList[indexInUse].databaseId);
    print('Items added');
    alreadySaved = SavedState.saved;
    _workOutName = '';
    _workOutDescription = '';
  }

  void deleteComponent() async {
    await DatabaseManager.instance.deleteComponent(statelessEditingComponetCardList[indexInUse].databaseId);
  }

  void rebuildList() {
    statelessEditingComponetCardList = statelessEditingComponetCardList;
  }
  
}