import 'package:word_api/word_api.dart';

class WordRepository {
  const WordRepository({required WordApi wordApi}) : _wordApi = wordApi;

  final WordApi _wordApi;

  Future<List<Word>> getWords() => _wordApi.getWords();

  Future<void> add(Word word) => _wordApi.add(word);

  Future<void> remove(int id) => _wordApi.remove(id);

  Future<void> update(Word word) => _wordApi.update(word);
}
