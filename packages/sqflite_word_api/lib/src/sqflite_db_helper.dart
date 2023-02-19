import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_word_api/src/pack_api.dart';
import 'package:word_api/word_api.dart';

import 'constant.dart';

class SqfliteDbHelper extends WordApi{
  PackAPI packAPI = PackAPI();
  String smallPackPath = 'assets/data_source/small_word_pack.json';

  Future<void> deleteDatabase() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    databaseFactory.deleteDatabase(dbPath);
  }

  @override
  Future<List<Word>> getWords({required AddedBy addedBy}) async {
    if(addedBy.name == AddedBy.smallPack.name){
      return await packAPI.getWordsFromSingleTable(smallPackTable);
    }
    if(addedBy.name == AddedBy.user.name){
      return await packAPI.getWordsFromSingleTable(userTable);
    }
    return [];
  }

  @override
  Future<List<Word>> getAllWords() async {
    List<Word> words = [
      ...await packAPI.getWordsFromSingleTable(userTable),
      ...await packAPI.getWordsFromSingleTable(smallPackTable)
    ];
    return words;
  }

  @override
  Future<void> add({required Word word}) async {
    await packAPI.add(word);
  }

  @override
  Future<void> fetchFromJson({required AddedBy addedBy}) async {
    if (addedBy.name == AddedBy.smallPack.name) {
      await packAPI.addFromJSON(smallPackTable, smallPackPath);
    }
  }

  @override
  Future<void> remove({required Word word}) async {
    if(word.addedBy.name == AddedBy.smallPack.name){
      await packAPI.remove(word.id, smallPackTable);
    }
    if(word.addedBy.name == AddedBy.user.name){
      await packAPI.remove(word.id, userTable);
    }
  }


  @override
  Future<void> clear({AddedBy? addedBy}) async {
    if(addedBy != null){
      if(AddedBy.smallPack.name == addedBy.name){
        await packAPI.clear(smallPackTable);
      }
      if(AddedBy.user.name == addedBy.name){
        await packAPI.clear(userTable);
      }
    }else {
      await packAPI.clear(smallPackTable);
      await packAPI.clear(userTable);
    }
  }

  @override
  Future<void> update({required Word word}) async {
    if(word.addedBy.name == AddedBy.smallPack.name){
      await packAPI.update(word, smallPackTable);
    }
    if(word.addedBy.name == AddedBy.user.name){
      await packAPI.update(word, userTable);
    }
  }
}
