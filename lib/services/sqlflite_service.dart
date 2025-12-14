import 'dart:convert';

import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlfliteService {
  late Database database;

  Future<void> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    database = await openDatabase(
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
    database = await openDatabase(join(await getDatabasesPath(), 'demo.db'));
    await database.transaction((txn) async {
      await txn.insert('prefs', data.toJson());
    });
  }

  // Update some record
  Future<void> update() async {
    int count = await database.rawUpdate(
      'UPDATE Test SET name = ?, value = ?, num = ? WHERE id = ?',
      ['updated name', 9876, 456.789, 1],
    );
    assert(count == 1);
  }

  // Get the records
  Future<List<ApodList>> getRecords() async {
    List<Map> results = await database.query('prefs');
    return apodListFromJson(json.encode(results));
  }

  // Count the records
  Future<int> countRecords() async {
    int count =
        Sqflite.firstIntValue(
          await database.rawQuery('SELECT COUNT(*) FROM prefs'),
        ) ??
        0;
    assert(count >= 0);
    return count;
  }

  //Check if exists an specific record
  Future<bool> exists(DateTime date) async {
    int count =
        Sqflite.firstIntValue(
          await database.query('prefs', where: 'date = ?', whereArgs: [date]),
        ) ??
        0;
    return count == 1;
  }

  // Delete a record
  Future<void> delete(int id) async {
    int count = await database.delete(
      'prefs',
      where: 'id = ?',
      whereArgs: [id],
    );
    assert(count == 1);
  }

  // Close the database
  Future<void> close() async {
    await database.close();
  }
}
