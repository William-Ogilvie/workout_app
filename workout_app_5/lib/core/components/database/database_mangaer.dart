import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static final _dbName = 'primaryDatabase.db';
  static final _dbVersion = 1;

  static final _tableWorkOutComponents = 'workOutComponenets';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnDescription = 'description';
  static final columnType = 'type';
  static final columnRestTime = 'restTime';

  static final _tableWorkOutCourses = 'workOutCourses';
  static final columnCourseNumber = 'course_number';
  static final columnCourseTimes = 'course_times';

  String _path;

  //making a singleton class
  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    _path = join(directory.path, _dbName);
    return await openDatabase(_path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableWorkOutCourses(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnCourseNumber TEXT NOT NULL,
      $columnCourseTimes TEXT NOT NULL,
      $columnRestTime TEXT NOT NULL
      )
      ''');
    db.execute('''
      CREATE TABLE $_tableWorkOutComponents(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnDescription TEXT,
      $columnType TEXT NOT NULL
      )
      ''');
    db.execute('''
      INSERT INTO $_tableWorkOutComponents ($columnName, $columnDescription, $columnType) VALUES
      $_openingSQLInsertion
      ''');
    return db.execute('''
      INSERT INTO $_tableWorkOutCourses ($columnName, $columnCourseNumber, $columnCourseTimes, $columnRestTime) VALUES
      ("Personal Workout", "16#11#13#14#8#10#2#5#18#6#9#3#7#4#15#1#17#12", "60#100#60#100#60#180#60#100#60#30#60#20#60#20#60#30#60#20", "20")
      ''');
  }

  Future<Map> querryWorkOutCourse(int id) async {
    Database db = await instance.database;

    List<Map> maps = await db.query(
      _tableWorkOutCourses,
      columns: [columnCourseNumber, columnRestTime, columnCourseTimes],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      var temp = maps.first;
      return temp;
    }
    return null;
  }

  Future<Map<String, dynamic>> querryWorkOutComponent(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(
      _tableWorkOutComponents,
      columns: [columnName, columnDescription, columnType],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> querryAllComponenets() async {
    Database db = await instance.database;
    return await db.query(_tableWorkOutComponents,
        columns: [columnName, columnDescription, columnType, columnId]);
  }

  Future<List<Map<String, dynamic>>> querryAllCourses() async {
    Database db = await instance.database;
    return await db
        .query(_tableWorkOutCourses, columns: [columnName, columnId, columnRestTime]);
  }

  Future<List<Map<String, dynamic>>> querryAll() async {
    Database db = await instance.database;
    return await db.query(_tableWorkOutComponents);
  }

  Future deletedatabase() async {
    return await deleteDatabase(_path);
  }

  Future insertComponent({String name, String desc, String type}) async {
    Database db = await instance.database;
    return await db.execute('''
      INSERT INTO $_tableWorkOutComponents ($columnName, $columnDescription, $columnType) VALUES
      ("${name.trim()}","${desc.trim()}","${type.trim()}")
      ''');
  }

  Future insertCourse({
      String courseName, String courseNumber, String courseTimes, String courseRestTime}) async {
    Database db = await instance.database;
    return await db.execute('''
      INSERT INTO $_tableWorkOutCourses ($columnName,  $columnCourseNumber, $columnCourseTimes, $columnRestTime) VALUES
      ("$courseName","$courseNumber","${courseTimes.trim()}", "$courseRestTime")
      ''');
  }

  Future updateCourse({String courseName, String courseNumber,
      String courseTimes, String courseRestTime, int id}) async {
    Database db = await instance.database;
    return await db.execute('''
      UPDATE $_tableWorkOutCourses
      SET $columnName = "$courseName",$columnCourseNumber = "$courseNumber", $columnCourseTimes = "${courseTimes.trim()}", $columnRestTime = "$courseRestTime"
      WHERE $columnId = $id;
      ''');
  }

  Future updateComponent({String componentName, String componentDescription,
      String type, int id}) async {
    Database db = await instance.database;
    return await db.execute('''
      UPDATE $_tableWorkOutComponents 
      SET $columnName = "$componentName",$columnDescription = "$componentDescription", $columnType = "$type"
      WHERE $columnId = "$id";
      ''');
  }

  Future deleteComponent({int id}) async {
    Database db = await instance.database;
    await deleteInstancesOfComponent(id: id);
    return await db.execute('''
      DELETE FROM $_tableWorkOutComponents
      WHERE $columnId = $id;
      ''');
  }

  Future deleteInstancesOfComponent({int id}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> _tempMapList;
    String _currentCourseNumber;
    List<String> _currentCourseNumberList;
    String _currentTimes;
    List<String> _currentTimesList;
    bool rebuild = false;

    _tempMapList = await db.query(_tableWorkOutCourses,
        columns: [columnCourseNumber, columnName, columnId, columnRestTime, columnCourseTimes]);

    for (int index1 = 0; index1 < _tempMapList.length; index1++) {
      _currentCourseNumber = _tempMapList[index1].values.first;

      _currentCourseNumberList = _currentCourseNumber.split('#');

      _currentTimes = _tempMapList[index1].values.last;
      _currentTimesList = _currentTimes.split('#');

      print('Pre times are $_currentTimesList');
      print('Pre course numbers are $_currentCourseNumberList');

      for (int index = 0; index < _currentCourseNumberList.length; index++) {
        if (int.parse(_currentCourseNumberList[index]) == id) {
          _currentCourseNumberList.removeAt(index);
          _currentTimesList.removeAt(index);
          rebuild = true;
        }
      }
      print('Current times are $_currentTimesList');
      print('Current course numbers$_currentCourseNumberList');

      if (rebuild == true) {
        String tempSQLNumber = '';
        String tempSQLReps = '';
        String workOutName = _tempMapList[index1].values.elementAt(1);
        int id = _tempMapList[index1].values.elementAt(2);
        String restTime = _tempMapList[index1].values.elementAt(3);


        for (int _index = 0;
            _index < _currentCourseNumberList.length;
            _index++) {
          switch (_index) {
            case 0:
              tempSQLNumber = '${_currentCourseNumberList[_index]}';
              tempSQLReps = '${_currentTimesList[_index]}';
              break;
            default:
              tempSQLNumber =
                  '$tempSQLNumber#${_currentCourseNumberList[_index]}';
              tempSQLReps = '$tempSQLReps#${_currentTimesList[_index]}';
          }
        }


        tempSQLNumber.replaceRange(
            tempSQLNumber.length, tempSQLNumber.length, '');
        tempSQLNumber.trim();
        tempSQLReps.replaceRange(tempSQLReps.length, tempSQLReps.length, '');
        tempSQLReps.trim();
        print(tempSQLNumber);
        print(tempSQLReps);

        DatabaseManager.instance.updateCourse(courseName: workOutName, courseNumber: tempSQLNumber, courseTimes: tempSQLReps, courseRestTime: restTime, id: id);
      }
    }
    print('Final times are $_currentTimesList');
    print('Final course numbers $_currentCourseNumberList');
  }

  Future deleteCourse(int id) async {
    Database db = await instance.database;
    db.execute(
      '''
      DELETE FROM $_tableWorkOutCourses 
      WHERE $columnId = $id;
      '''
    );
  }

  static final String _openingSQLInsertion = '''
  ("Burpees", "Fun", "Reps"),
  ("Buttterfly Stretch", "Sit in butterfly position and then pull head to knees", "Time"),
  ("Dumbell Front Extended", "Lift dumbell straight in front of you", "Reps"),
  ("Dumbell Side","Extend arms sideways","Reps"),
  ("Dumbell Standard","Lift Dumbell up towards you","Reps"),
  ("Dumbell Up","Lift Dumbell directly above head","Reps"),
  ("Knee to Chest Stretch","Lie on back and pull one knee in towards your chest","Time"),
  ("Lunge With Spinal Twist","Lunge and extend one hand out above head","Time"),
  ("Lunging Stretch","Perfom a lunge but extend further","Time"),
  ("Plank","Hold a plank position","Time"),
  ("Press Ups","Do press ups","Reps"),
  ("Pull Ups","Do pull ups","Reps"),
  ("Shoulder Squeeze Stretch","Extend both arms behind you and stretch with hands linked","Time"),
  ("Sit Ups","Do sit ups","Reps"),
  ("Sphinx Pose","Lie flat facing forward and push body up","Time"),
  ("Standing Hamstring Stretch","Reach down touch toes","Time"),
  ("Standing Quad Stretch","Stand up straight and pull one leg in behind","Time"),
  ("Triceps Stretch","Reach one hand behind back and stretch","Time")
  ''';
}
