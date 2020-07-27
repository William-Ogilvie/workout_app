import 'package:flutter/cupertino.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/widgets/editing/stateless_editing_course_card.dart';
import 'package:workout_app_5/widgets/selection/stateless_selection_card.dart';

class WorkOutSelectionProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mapList = [];

  List<StatelessSelectionCard> _statelessSelectionCardList = [];

  List<StatelessSelectionCard> get statelessSelectionCardList =>
      _statelessSelectionCardList;

  set statelessSelectionCardList(List<StatelessSelectionCard> val) {
    _statelessSelectionCardList = val;
    notifyListeners();
  }

  List<StatelessEditingSelectionCourseCard>
      _statelessEditingSelectionCourseCard = [];

  List<StatelessEditingSelectionCourseCard>
      get statelessEditingSelectionCourseCard =>
          _statelessEditingSelectionCourseCard;

  set statelessEditingSelectionCourseCard(
      List<StatelessEditingSelectionCourseCard> val) {
    _statelessEditingSelectionCourseCard = val;
    notifyListeners();
  }

  Future launch() async {
    statelessSelectionCardList = [];
    _mapList = await DatabaseManager.instance.querryAllCourses();
    for (int _index = 0; _index < _mapList.length; _index++) {
      StatelessSelectionCard tempCard = StatelessSelectionCard(
        courseName: _mapList[_index].values.elementAt(0),
        databaseId: _mapList[_index].values.elementAt(1),
      );

      statelessSelectionCardList.add(tempCard);
    }
    print('ha ha');
  }

  void launchEditMode() async {
    statelessEditingSelectionCourseCard = [];
    _mapList = await DatabaseManager.instance.querryAllCourses();
    for (int _index = 0; _index < _mapList.length; _index++) {
      StatelessEditingSelectionCourseCard tempCard = StatelessEditingSelectionCourseCard(
        courseName: _mapList[_index].values.elementAt(0),
        databaseId: _mapList[_index].values.elementAt(1),
        courseRestTimes: _mapList[_index].values.elementAt(2),
      );

      statelessEditingSelectionCourseCard.add(tempCard);
    }
    statelessEditingSelectionCourseCard = statelessEditingSelectionCourseCard;
  }
}
