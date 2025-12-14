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
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)',
        );
      },
    );
  }

  // Delete the database
  Future<void> deleteDatabase(String path) async {
    await deleteDatabase(path);
  }

  // Insert some records in a transaction
  Future<void> insertInTransaction() async {
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
        'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)',
      );
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
        'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
        ['another name', 12345678, 3.1416],
      );
      print('inserted2: $id2');
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
  Future<void> getRecords() async {
    List<Map> results = await database.query('Test', columns: ['id', 'name']);
    assert(results.length == 2);
    assert(results[0]['id'] == 1);
    assert(results[0]['name'] == 'some name');
    assert(results[1]['id'] == 2);
    assert(results[1]['name'] == 'another name');
  }

  // Count the records
  Future<void> countRecords() async {
    int count =
        Sqflite.firstIntValue(
          await database.rawQuery('SELECT COUNT(*) FROM Test'),
        ) ??
        0;
    assert(count == 2);
  }

  // Delete a record
  Future<void> delete() async {
    int count = await database.delete('Test', where: 'id = ?', whereArgs: [1]);
    assert(count == 1);
  }

  // Close the database
  Future<void> close() async {
    await database.close();
  }
}
