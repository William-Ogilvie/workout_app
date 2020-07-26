

import 'package:flutter/cupertino.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/enums/already_saved.dart';

class ComponentCreationProvider extends ChangeNotifier {

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

 

  void insertWorkOutComponent() async{
    print(_workOutName);
    print(_workOutDescription);
    print(timeOrReps);
    await DatabaseManager.instance.insertComponent(name: _workOutName, desc: _workOutDescription, type: timeOrReps);
    print('Items added');
    _workOutName = '';
    _workOutDescription = '';
    alreadySaved = SavedState.saved;
  }


}