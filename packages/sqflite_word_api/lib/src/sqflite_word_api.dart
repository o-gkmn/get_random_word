import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_word_api/src/constant.dart';
import 'package:word_api/word_api.dart';

class SqfliteWordApi extends WordApi {
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

  Future<void> deleteDatabase() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    databaseFactory.deleteDatabase(dbPath);
  }

  void createTable(Database db, int version) async {
    db.execute(
        "Create table $table($columnId integer primary key AUTOINCREMENT, $columnEnglish text, $columnTurkish text)");
  }

  @override
  Future<List<Word>> getWords() async {
    Database? db = await this.db;
    var result = await db!.query(table);

    return List.generate(result.length, (index) {
      return Word.fromJson(result[index]);
    });
  }

  @override
  Future<void> add(Word word) async {
    Database? db = await this.db;
    await db!.insert(table, word.toJson());
  }

  @override
  Future<void> remove(int id) async {
    Database? db = await this.db;
    await db!.delete(table, where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(Word word) async {
    Database? db = await this.db;
    await db!.update(table, word.toJson(), where: "id=?", whereArgs: [word.id]);
  }
}
