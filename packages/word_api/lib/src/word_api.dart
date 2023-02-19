import 'package:word_api/word_api.dart';

abstract class WordApi {
  const WordApi();

  Future<List<Word>> getAllWords();

  Future<List<Word>> getWords({required AddedBy addedBy});

  Future<void> fetchFromJson({required AddedBy addedBy});

  Future<void> add({required Word word});

  Future<void> remove({required AddedBy addedBy, required int id});

  Future<void> clear({AddedBy? addedBy});

  Future<void> update({required Word word});
}

class WordNotFoundExceptions implements Exception {}
