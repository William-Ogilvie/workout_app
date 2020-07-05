import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_app_5/core/components/database/database_storage.dart';


class DatabaseManager {

  static final _dbName = 'primaryDatabase.db';
  static final _dbVersion = 1;

  static final _tableWorkOutComponents = 'workOutComponenets';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnDescription = 'description';
  static final columnType = 'type';

  static final _tableWorkOutCourses = 'workOutCourses';
  static final columnCourseNumber = 'course_number';
  static final columnCourseTimes = 'course_times';

  String _path;

  //making a singleton class
  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if(_database != null) {
      return _database;
    }

    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    _path = join(directory.path,_dbName);
    return await openDatabase(_path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    
    db.execute(
      '''
      CREATE TABLE $_tableWorkOutCourses(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnCourseNumber TEXT NOT NULL,
      $columnCourseTimes TEXT NOT NULL
      )
      '''
    );
    db.execute(
      '''
      CREATE TABLE $_tableWorkOutComponents(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnDescription TEXT,
      $columnType TEXT NOT NULL
      )
      '''
    );
    db.execute(
      '''
      INSERT INTO $_tableWorkOutComponents ($columnName, $columnDescription, $columnType) VALUES
      $_openingSQLInsertion
      '''
    );
    return db.execute(
      '''
      INSERT INTO $_tableWorkOutCourses ($columnName, $columnCourseNumber, $columnCourseTimes) VALUES
      ("Personal Workout", "16#11#13#14#8#10#2#5#18#6#9#3#7#4#15#1#17#12", "60#30#60#100#60#120#60#40#60#20#60#20#60#20#60#30#60#10")
      '''
    );
  }

  Future <Map> querryWorkOutCourse(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_tableWorkOutCourses,columns: [columnCourseNumber,columnCourseTimes],where: '$columnId = ?',whereArgs: [id],);
    if(maps.length > 0) {
      var temp = maps.first;
      var temp2 = maps.last;
      var temp3 = {};
      temp3.addAll(temp);
      temp3.addAll(temp2);
      return temp3;
    }
    return null;
  }

  Future<Map<String, dynamic>> querryWorkOutComponent(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_tableWorkOutComponents,columns: [columnName, columnDescription, columnType],where: '$columnId = ?',whereArgs: [id],);
    if(maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map<String,dynamic>>> querryAll() async {
    Database db = await instance.database;
    return await db.query(_tableWorkOutComponents,columns: [columnName]);
  }

  Future deletedatabase() async {
    Database db = await instance.database;
    return await deleteDatabase(_path);
  }

  Future insertComponent(String name, String desc, String type) async{
    Database db = await instance.database;
    return await db.execute(
      '''
      INSERT INTO $_tableWorkOutComponents ($columnName, $columnDescription, $columnType) VALUES
      ("${name.trim()}","${desc.trim()}","${type.trim()}")
      '''
    );
  }

  static final String _openingSQLInsertion = 
  '''
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