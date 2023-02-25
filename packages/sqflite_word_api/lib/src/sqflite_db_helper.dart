import 'dart:async';

import 'package:sqflite_word_api/src/pack_api.dart';
import 'package:word_api/word_api.dart';

import 'constant.dart';

class SqfliteDbHelper extends WordApi {
  final PackAPI packAPI = PackAPI();

  final StreamController<List<Word>> _controller =
      StreamController<List<Word>>.broadcast();

  final String smallPackPath = 'assets/data_source/small_word_pack.json';
  final String mediumPackPath = 'assets/data_source/medium_word_pack.json';
  final String largePackPath = "assets/data_source/large_word_pack.json";

  @override
  Future<List<Word>> getWords({required AddedBy addedBy}) async {
    if (addedBy.name == AddedBy.smallPack.name) {
      return await packAPI.getWordsFromSingleTable(smallPackTable);
    }
    if (addedBy.name == AddedBy.mediumPack.name) {
      return await packAPI.getWordsFromSingleTable(mediumPackTable);
    }
    if (addedBy.name == AddedBy.largePack.name) {
      return await packAPI.getWordsFromSingleTable(largePackTable);
    }
    if (addedBy.name == AddedBy.user.name) {
      return await packAPI.getWordsFromSingleTable(userTable);
    }
    return [];
  }

  @override
  Future<List<Word>> getAllWords() async {
    List<Word> words = [
      ...await packAPI.getWordsFromSingleTable(userTable),
      ...await packAPI.getWordsFromSingleTable(smallPackTable),
      ...await packAPI.getWordsFromSingleTable(mediumPackTable),
      ...await packAPI.getWordsFromSingleTable(largePackTable),
    ];

    _controller.add(words);
    return words;
  }

  @override
  Stream<List<Word>> listenWordsLists() async* {
    yield* _controller.stream.asBroadcastStream();
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
    if (addedBy.name == AddedBy.mediumPack.name) {
      await packAPI.addFromJSON(mediumPackTable, mediumPackPath);
    }
    if (addedBy.name == AddedBy.largePack.name) {
      await packAPI.addFromJSON(largePackTable, largePackPath);
    }
  }

  @override
  Future<void> remove({required Word word}) async {
    if (word.addedBy.name == AddedBy.smallPack.name) {
      await packAPI.remove(word.id, smallPackTable);
    }
    if (word.addedBy.name == AddedBy.mediumPack.name) {
      await packAPI.remove(word.id, mediumPackTable);
    }
    if (word.addedBy.name == AddedBy.user.name) {
      await packAPI.remove(word.id, userTable);
    }
    if (word.addedBy.name == AddedBy.largePack.name) {
      await packAPI.remove(word.id, largePackTable);
    }
  }

  @override
  Future<void> clear({AddedBy? addedBy}) async {
    if (addedBy != null) {
      if (AddedBy.smallPack.name == addedBy.name) {
        await packAPI.clear(smallPackTable);
      }
      if (addedBy.name == AddedBy.mediumPack.name) {
        await packAPI.clear(mediumPackTable);
      }
      if (addedBy.name == AddedBy.largePack.name) {
        await packAPI.clear(largePackTable);
      }
      if (AddedBy.user.name == addedBy.name) {
        await packAPI.clear(userTable);
      }
    } else {
      await packAPI.clear(smallPackTable);
      await packAPI.clear(mediumPackTable);
      await packAPI.clear(largePackTable);
      await packAPI.clear(userTable);
    }
  }

  @override
  Future<void> update({required Word word}) async {
    if (word.addedBy.name == AddedBy.smallPack.name) {
      await packAPI.update(word, smallPackTable);
    }
    if (word.addedBy.name == AddedBy.mediumPack.name) {
      await packAPI.update(word, mediumPackTable);
    }
    if (word.addedBy.name == AddedBy.user.name) {
      await packAPI.update(word, userTable);
    }
  }

  @override
  Future<void> dispose() async {
    await _controller.close();
  }
}
