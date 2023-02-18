import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_word_api/src/small_word_pack_api.dart';
import 'package:sqflite_word_api/src/user_word_pack_api.dart';
import 'package:word_api/word_api.dart';

import 'constant.dart';

class SqfliteDbHelper {
  Database? _db;
  final UserWordPackAPI userWordPackAPI = UserWordPackAPI();
  final SmallWordPackAPI smallWordPackAPI = SmallWordPackAPI(database: db);

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    var wordsDb = await openDatabase(dbPath, version: 1);
    return wordsDb;
  }

  Future<void> deleteDatabase() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    databaseFactory.deleteDatabase(dbPath);
  }

  Future<List<Word>> getAllWords() async {
    List<Word> words = [
      ...await userWordPackAPI.getWords(),
      ...await smallWordPackAPI.getWords()
    ];
    return words;
  }

  Future<void> add({required AddedBy addedBy, Word? word}) async {
    if (addedBy.name == AddedBy.smallPack.name) {
      await smallWordPackAPI.add();
    } else {
      if (word != null) {
        await userWordPackAPI.add(word);
      }
    }
  }

  Future<void> remove({required AddedBy addedBy, required int id}) async {
    if(addedBy.name == AddedBy.smallPack.name){
      await smallWordPackAPI.remove(id);
    }
    if(addedBy.name == AddedBy.user.name){
      await userWordPackAPI.remove(id);
    }
  }

  Future<void> clear({AddedBy? addedBy}) async {
    if(addedBy != null){
      if(AddedBy.smallPack.name == addedBy.name){
        await smallWordPackAPI.clear();
      }
      if(AddedBy.user.name == addedBy.name){
        await userWordPackAPI.clear();
      }
    }else {
      await smallWordPackAPI.clear();
      await userWordPackAPI.clear();
    }
  }

  Future<void> update({required Word word}) async {
    if(word.addedBy.name == AddedBy.smallPack.name){
      await smallWordPackAPI.update(word);
    }
    if(word.addedBy.name == AddedBy.user.name){
      await userWordPackAPI.update(word);
    }
  }
}
