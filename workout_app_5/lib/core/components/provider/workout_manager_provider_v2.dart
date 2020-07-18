import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:workout_app_5/core/components/database/database_mangaer.dart';
import 'package:workout_app_5/core/components/provider/sound_player_provider.dart';
import 'package:workout_app_5/core/components/provider/text_to_speech_provider.dart';
import 'package:workout_app_5/enums/sound_player_state.dart';
import 'package:workout_app_5/enums/workout_screen_state.dart';

class WorkOutManagerProviderV2 extends ChangeNotifier {
  TextToSpeechProvider textToSpeechProvider = TextToSpeechProvider();
  SoundPlayer soundPlayer = SoundPlayer();

  int _repNumber;
  int _currentTime;
  int _currentCourseIndex = 0;
  int _restTime = 0;

  String _workOutName = '';
  String _workOutDescription;
  String _currentCourseNumber;
  String _currentCourseTimes;
  String _repsOrSeconds;
  String _sayRepsOrSeconds;

  List<String> _currentCourseNumberList;
  List<String> _currentCourseTimesList;

  bool _useTimer = false;
  bool _cancelTimer = false;
  bool _workOutEnded = false;
  bool _pauseTimer = false;
  bool _stopTimerNoMatterWhat = false;

  WorkOutScreenState _workOutScreenState = WorkOutScreenState.exercise;

  int get repNumber => _repNumber;

  set repNumber(int val) {
    _repNumber = val;
    notifyListeners();
  }

  int get currentTime => _currentTime;

  set currentTime(int val) {
    _currentTime = val;
    notifyListeners();
  }

  String get workOutName => _workOutName;

  set workOutName(String val) {
    _workOutName = val;
    notifyListeners();
  }

  String get workOutDescription => _workOutDescription;

  set workOutDescription(String val) {
    _workOutDescription = val;
    notifyListeners();
  }

  bool get useTimer => _useTimer;

  set useTimer(bool val) {
    _useTimer = val;
    notifyListeners();
  }

  bool get workOutEnded => _workOutEnded;

  set workOutEnded(bool val) {
    _workOutEnded = val;
    notifyListeners();
  }

  WorkOutScreenState get workOutScreenState => _workOutScreenState;

  set workOutScreenState(WorkOutScreenState val) {
    _workOutScreenState = val;
    notifyListeners();
  }

  void setWorkOutCourse(int id) async {
    textToSpeechProvider.initFlutterTTS();
    await soundPlayer.loadSound();
    var temp = await DatabaseManager.instance.querryWorkOutCourse(id);
    _currentCourseNumber = temp.values.elementAt(0).toString();
    _currentCourseNumberList = _currentCourseNumber.split('#');
    _currentCourseTimes = temp.values.elementAt(2).toString();
    _currentCourseTimesList = _currentCourseTimes.split('#');
    _restTime = int.parse(temp.values.elementAt(1));
    print(_currentCourseNumberList);
    print(_currentCourseTimesList);
  }

  void activateWorkOut() async {
    workOutEnded = false;
    useTimer = false;
    _stopTimerNoMatterWhat = false;
    _workOutScreenState = WorkOutScreenState.exercise;
    _sayRepsOrSeconds = 'Reps';

    var tempId;
    try {
      tempId = int.parse(_currentCourseNumberList[_currentCourseIndex].trim());
    } catch (e) {
      workOutEnded = true;
      return null;
    }

    var map = await DatabaseManager.instance.querryWorkOutComponent(tempId);
    var tempList = map.values.toList();

    workOutName = tempList[0].toString().trim();
    workOutDescription = tempList[1].toString().trim();
    _repsOrSeconds = tempList[2].toString().trim();
    repNumber = int.parse(_currentCourseTimesList[_currentCourseIndex]);

    print(tempList);
    print(workOutName);
    print(workOutDescription);
    print(_repsOrSeconds);
    print(repNumber);

    if (_repsOrSeconds == 'Time') {
      useTimer = true;
      _sayRepsOrSeconds = 'seconds';
      playTimer(repNumber);
    }

    textToSpeechProvider
        .speak('{$workOutName} for {$repNumber} {$_sayRepsOrSeconds}');
  }

  void checkWorkOutEnded() {
    var tempId;
    try {
      tempId = int.parse(_currentCourseNumberList[_currentCourseIndex].trim());
    } catch (e) {
      workOutEnded = true;
      _stopTimerNoMatterWhat = true;
      return null;
    }
  }

  playTimer(int timeDuration) {
    _currentTime = timeDuration;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (_stopTimerNoMatterWhat == true) {
        t.cancel();
      } else if (_currentTime < 1 || _cancelTimer == true) {
        t.cancel();
        soundPlayer.resetSoundPlayerState();
        print('Timer Cancelled');
        if (_pauseTimer != true) {
          workOutScreenState == WorkOutScreenState.exercise
              ? finishExercise()
              : finishRestScreen();
        }
      } else if (_currentTime < 4 &&
          soundPlayer.soundPlayerState == SoundPlayerState.idle) {
        soundPlayer.playSound();
      } else {
        currentTime--;
        print(currentTime);
      }
    });
  }

  void finishExercise() {
    workOutScreenState = WorkOutScreenState.rest;
    resetTimer();
    incrementIndex();
    playTimer(_restTime);
    checkWorkOutEnded();
  }

  void finishRestScreen() {
    workOutScreenState = WorkOutScreenState.exercise;
    resetTimer();
    activateWorkOut();
  }

  void resetTimer() {
    currentTime = 0;
    _cancelTimer = false;
    _pauseTimer = false;
  }

  void setCancelTimerTrue() {
    _pauseTimer = false;
    _cancelTimer = true;
  }

  void disableTimer() {
    _cancelTimer = true;
    _pauseTimer = true;
  }

  void restartTimer() {
    _cancelTimer = false;
    _pauseTimer = false;
    _useTimer ? playTimer(_currentTime) : print('Gotta');
  }

  void incrementIndex() {
    _currentCourseIndex++;
  }

  void clearIndex() {
    _currentCourseIndex = 0;
  }

  void fullReset() {
    _currentCourseIndex = 0;
    _useTimer = false;
    workOutScreenState = WorkOutScreenState.exercise;
    _cancelTimer = false;
    _workOutEnded = false;
    _pauseTimer = false;
  }
}
