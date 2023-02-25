import 'package:word_api/word_api.dart';

abstract class WordApi {
  const WordApi();

  Future<List<Word>> getAllWords();

  Future<List<Word>> getWords({required AddedBy addedBy});

  Stream<List<Word>> listenWordsLists();

  Future<void> fetchFromJson({required AddedBy addedBy});

  Future<void> add({required Word word});

  Future<void> remove({required Word word});

  Future<void> clear({AddedBy? addedBy});

  Future<void> update({required Word word});

  Future<void> dispose();
}

class WordNotFoundExceptions implements Exception {}
