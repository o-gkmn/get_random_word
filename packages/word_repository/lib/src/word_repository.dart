import 'package:word_api/word_api.dart';

class WordRepository {
  const WordRepository({required WordApi wordApi}) : _wordApi = wordApi;

  final WordApi _wordApi;

  Future<List<Word>> getAllWords() => _wordApi.getAllWords();

  Future<List<Word>> getWords({required AddedBy addedBy}) =>
      _wordApi.getWords(addedBy: addedBy);

  Stream<List<Word>> listenWordsList() => _wordApi.listenWordsLists();

  Future<void> fetchFromJson({required AddedBy addedBy}) =>
      _wordApi.fetchFromJson(addedBy: addedBy);

  Future<void> add({required Word word}) => _wordApi.add(word: word);

  Future<void> remove({required Word word}) => _wordApi.remove(word: word);

  Future<void> clear({AddedBy? addedBy}) => _wordApi.clear(addedBy: addedBy);

  Future<void> update({required Word word}) => _wordApi.update(word: word);

  Future<void> dispose() => _wordApi.dispose();
}
