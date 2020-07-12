import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';

class ComponentCreationProvider extends ChangeNotifier {

  String _workOutName;
  String _workOutDescription;
  String _timeOrReps = 'Reps';

  

  String get timeOrReps => _timeOrReps;

  set timeOrReps(String val) {
    _timeOrReps = val;
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
    await DatabaseManager.instance.insertComponent(_workOutName, _workOutDescription, timeOrReps);
    print('Items added');
    _workOutName = '';
    _workOutDescription = '';
  }


}