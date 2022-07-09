import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/model_constant.dart';
import '../models/words.dart';

class DbHelper {
  Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    var wordsDb = await openDatabase(dbPath, version: 1, onCreate: createTable);
    return wordsDb;
  }

  void createTable(Database db, int version) async {
    db.execute(
        "Create table $table($columnId integer primary key, $columnEnglish text, $columnTurkish text)");
  }

  Future<List> getWords() async {
    Database? db = await this.db;
    var result = await db!.query(table);

    return List.generate(result.length, (index) {
      return Words.fromObject(result[index]);
    });
  }

  Future<int> insert(Words words) async {
    Database? db = await this.db;
    var result = await db!.insert(table, words.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database? db = await this.db;
    var result = await db!.delete(table, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<int> update(Words words) async {
    Database? db = await this.db;
    var result =
        db!.update(table, words.toMap(), where: "id=?", whereArgs: [words.id]);
    return result;
  }
}
