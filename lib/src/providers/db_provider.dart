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
    String path = join(documentsDirectory.path, "asistenterrhh.db");
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
          "area TEXT,"
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
    var res = await db.insert("interviewed", newInterviewed.toMap());
    return res;
  }

  applyFilters(String status) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM interviewed WHERE status LIKE '%$status%' ORDER BY id DESC");
    List<Interviewed> list =
        res.isNotEmpty ? res.map((c) => Interviewed.fromMap(c)).toList() : [];
    return list;
  }

  getInterviewed(int id) async {
    final db = await database;
    var res = await  db.query("interviewed", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Interviewed.fromMap(res.first) : Null ;
  }

  Future<List<Interviewed>> search( String term )  async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM interviewed WHERE first_name LIKE '%$term%' OR last_name LIKE '%$term%' OR email LIKE '%$term%' ORDER BY id DESC");
    List<Interviewed> list =
        res.isNotEmpty ? res.map((c) => Interviewed.fromMap(c)).toList() : [];
    return list;
  }

  sendToTechnicalInterview( int id ) async {
    final db = await database;
    var res = await db.rawUpdate("UPDATE interviewed SET status = 'Technical Interview' WHERE id = ?", [id]);
    return res;
  }

  addTechnicalFeedback( String feedback, String interviewer, int id ) async {
    final db = await database;
    var res = await db.rawUpdate("UPDATE interviewed SET technical_feedback = ?, status = 'RRHH review', technical_interviewer = ?  WHERE id = ?", [feedback, interviewer, id]);
    return res;
  }

  reject( int id ) async {
    final db = await database;
    var res = await db.rawUpdate("UPDATE interviewed SET  status = 'Rejected'  WHERE id = ?", [id]);
    return res;
  }

  hired( int id ) async {
    final db = await database;
    var res = await db.rawUpdate("UPDATE interviewed SET status = 'Hired' WHERE id = ?", [id]);
    return res;
  }

  updateInterviewed(int id, Interviewed element) async {
    final db = await database;
    var res = await db.update('interviewed', element.toMap(), where: "id = ?", whereArgs: [element.id]);
    return res;
  }

}