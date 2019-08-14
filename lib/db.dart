import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'structs.dart';

// Database helper
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE Rooms(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
    await db.execute("CREATE TABLE Checks(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
    await db.execute("CREATE TABLE Reports(id INTEGER PRIMARY KEY, name TEXT, date TEXT)");
    await db.execute("CREATE TABLE ReportData(id INTEGER PRIMARY KEY, report INTEGER, check INTEGER, value INTEGER)");
  }

  // Operations
  Future<int> saveRoom(Rooms room) async {
    var dbClient = await db;
    return await dbClient.insert("Rooms", room.toMap());
  }

  Future<int> saveCheck(Checks check) async {
    var dbClient = await db;
    return await dbClient.insert("Checks", check.toMap());
  }

  Future<int> saveReport(Reports report) async {
    var dbClient = await db;
    return await dbClient.insert("Reports", report.toMap());
  }

  Future<int> saveData(ReportDataUnit data) async {
    var dbClient = await db;
    return await dbClient.insert("ReportData", data.toMap());
  }

  Future<int> deleteRoom(Rooms room) async {
    var dbClient = await db;
    await dbClient.rawDelete("DELETE FROM ReportData WHERE room = ?", [room.id]);
    return await dbClient.rawDelete("DELETE FROM Rooms WHERE id = ?", [room.id]);
  }

  Future<int> deleteCheck(Checks check) async {
    var dbClient = await db;
    await dbClient.rawDelete("DELETE FROM ReportData WHERE check = ?", [check.id]);
    return await dbClient.rawDelete("DELETE FROM Checks WHERE id = ?", [check.id]);
  }

  Future<int> deleteReport(Reports report) async {
    var dbClient = await db;
    await dbClient.rawDelete("DELETE FROM ReportData WHERE report = ?", [report.id]);
    return await dbClient.rawDelete("DELETE FROM Reports WHERE id = ?", [report.id]);
  }

  Future<int> deleteData(ReportDataUnit data) async {
    var dbClient = await db;
    return await dbClient.rawDelete("DELETE FROM ReportData WHERE id = ?", [data.id]);
  }

  Future<int> updateRoom(Rooms room) async {
    var dbClient = await db;
    return await dbClient.update("Rooms", room.toMap(), where: "id = ?", whereArgs: <int>[room.id]);
  }

  Future<int> updateCheck(Checks check) async {
    var dbClient = await db;
    return await dbClient.update("Checks", check.toMap(), where: "id = ?", whereArgs: <int>[check.id]);
  }

  Future<int> updateReport(Reports report) async {
    var dbClient = await db;
    return await dbClient.update("Reports", report.toMap(), where: "id = ?", whereArgs: <int>[report.id]);
  }

  Future<int> updateData(ReportDataUnit data) async {
    var dbClient = await db;
    return await dbClient.update("ReportData", data.toMap(), where: "id = ?", whereArgs: <int>[data.id]);
  }

  Future<List<Rooms>> getRooms() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Rooms');
    List<Rooms> roomList = new List();
    for (int i = 0; i < list.length; i++) {
      var room = new Rooms(list[i]["name"], list[i]["description"]);
      room.setRoomId(list[i]["id"]);
      roomList.add(room);
    }
    return roomList;
  }

  Future<List<Checks>> getChecks() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Checks');
    List<Checks> checkList = new List();
    for (int i = 0; i < list.length; i++) {
      var check = new Checks(list[i]["name"], list[i]["description"]);
      check.setCheckId(list[i]["id"]);
      checkList.add(check);
    }
    return checkList;
  }

  Future<List<Reports>> getReports() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Reports');
    List<Reports> reportList = new List();
    for (int i = 0; i < list.length; i++) {
      var report = new Reports(list[i]["name"], list[i]["date"]);
      report.setReportId(list[i]["id"]);
      reportList.add(report);
    }
    return reportList;
  }
}

// end of DB Helper
