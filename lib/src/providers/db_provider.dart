import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();
  static Database _database;

  DBProvider._();

  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test1.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE interviewed ("
          "id INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "email TEXT,"
          "english_level TEXT,"
          "linkedin_url TEXT,"
          "country TEXT,"
          "company TEXT,"
          "phone TEXT,"
          "skills TEXT,"
          "status TEXT,"
          "rrhh_interviewer TEXT,"
          "rrhh_feedback TEXT,"
          "reject_reason TEXT,"
          "technical_interviewer TEXT,"
          "technical_feedback TEXT,"
          "level_recommendation TEXT"
          ")");
    });
  }

  newInterviewed(Interviewed newInterviewed) async {
    final db = await database;
    print(newInterviewed);
    var res = await db.insert("interviewed", newInterviewed.toMap());
    print(res);
    return res;
  }

}