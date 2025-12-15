import 'dart:convert';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SqlfliteService {
  static final SqlfliteService _instance = SqlfliteService._internal();
  factory SqlfliteService() => _instance;
  static Database? _database;

  SqlfliteService._internal();

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'demo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE prefs (id INTEGER PRIMARY KEY AUTOINCREMENT, date DATETIME, explanation TEXT, media_type TEXT, service_version TEXT, title TEXT, url TEXT NULL, copyright TEXT NULL, hdurl TEXT NULL)',
        );
      },
    );
  }

  // Delete the database
  Future<void> deleteDatabase(String path) async {
    await deleteDatabase(path);
  }

  // Insert some records in a transaction
  Future<void> insertInTransaction(ApodList data) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('prefs', data.toJson());
    });
  }

  //Delete record
  Future<void> deleteRecord(DateTime date) async {
    final db = await database;
    await db.delete(
      'prefs',
      where: 'date = ?',
      whereArgs: [date.toIso8601String().substring(0, 10)],
    );
  }

  // Get the records
  Future<List<ApodList>> getRecords() async {
    final db = await database;
    List<Map> results = await db.query('prefs');
    return apodListFromJson(json.encode(results));
  }

  // Count the records
  Future<int> countRecords() async {
    final db = await database;
    int count =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM prefs'),
        ) ??
        0;
    assert(count >= 0);
    return count;
  }

  //Check if exists an specific record
  Future<bool> exists(DateTime date) async {
    final db = await database;
    int count =
        Sqflite.firstIntValue(
          await db.query(
            'prefs',
            where: 'date = ?',
            whereArgs: [date.toIso8601String().substring(0, 10)],
          ),
        ) ??
        0;
    return count >= 1;
  }

  // Delete a record
  Future<void> delete(int id) async {
    final db = await database;
    int count = await db.delete('prefs', where: 'id = ?', whereArgs: [id]);
    assert(count == 1);
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
