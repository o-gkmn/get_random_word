import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:word_api/word_api.dart';

import 'constant.dart';

class PackAPI {
  Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    var wordsDb = await openDatabase(dbPath, version: 1);
    return wordsDb;
  }

  void createTable(Database db, int version) async {
    var user = await db
        .rawQuery('SELECT * FROM sqlite_master WHERE name="$userTable";');
    var small = await db
        .rawQuery('SELECT * FROM sqlite_master WHERE name="$smallPackTable";');
    if (user.isEmpty) {
      db.execute(
        "Create table $userTable($columnId integer primary key AUTOINCREMENT, $columnEnglish text, $columnTurkish text, $columnAddedBy addedBy)",
      );
    }
    if (small.isEmpty) {
      db.execute(
        "Create table $smallPackTable($columnId integer primary key AUTOINCREMENT, $columnEnglish text, $columnTurkish text, $columnAddedBy addedBy)",
      );
    }
  }

  Future<void> deleteDatabase() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    databaseFactory.deleteDatabase(dbPath);
  }

  Future<List<Word>> getWordsFromSingleTable(String tableName) async {
    Database? db = await this.db;
    var result = await db!.query(tableName);

    return List.generate(result.length, (index) {
      return Word.fromJson(result[index]);
    });
  }

  Future<void> add(Word word) async {
    Database? db = await this.db;
    await db!.insert(userTable, word.toJson());
  }

  Future<void> addFromJSON(String tableName, String packPath) async {
    Database? db = await this.db;
    final String jsonData = await rootBundle.loadString(packPath);
    List<dynamic> wordsJson = jsonDecode(jsonData);

    db!.transaction((txn) async {
      for (var element in wordsJson) {
        await txn.insert(tableName, element);
      }
    });
  }

  Future<void> remove(int id, String tableName) async {
    Database? db = await this.db;
    await db!.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> clear(String tableName) async {
    Database? db = await this.db;
    await db!.delete(tableName);
  }

  Future<void> update(Word word, String tableName) async {
    Database? db = await this.db;
    await db!
        .update(tableName, word.toJson(), where: "id=?", whereArgs: [word.id]);
  }
}
