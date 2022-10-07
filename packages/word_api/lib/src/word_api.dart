import 'package:word_api/word_api.dart';

abstract class WordApi {
  const WordApi();

  Future<List<Word>> getWords();

  Future<void> add(Word word);

  Future<void> remove(int id);

  Future<void> update(Word word);
}

class WordNotFoundExceptions implements Exception {}
