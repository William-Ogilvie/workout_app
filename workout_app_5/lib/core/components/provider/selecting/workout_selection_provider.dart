import 'package:flutter/cupertino.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/widgets/selection/stateless_selection_card.dart';

class WorkOutSelectionProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mapList = [];
  
  List<StatelessSelectionCard> _statelessSelectionCardList = [];

  List<StatelessSelectionCard> get statelessSelectionCardList => _statelessSelectionCardList;

  set statelessSelectionCardList(List<StatelessSelectionCard> val) {
    _statelessSelectionCardList = val;
    notifyListeners();
  }


  void launch() async{
    statelessSelectionCardList = [];
    _mapList = await DatabaseManager.instance.querryAllCourses();
    for (int _index = 0; _index < _mapList.length; _index++) {
      StatelessSelectionCard tempCard = StatelessSelectionCard(
        courseName: _mapList[_index].values.elementAt(0),
        databaseId: _mapList[_index].values.elementAt(1),
      );      

      statelessSelectionCardList.add(tempCard);
    }
  }


}