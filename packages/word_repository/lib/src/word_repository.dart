import 'package:word_api/word_api.dart';

class WordRepository {
  const WordRepository({required WordApi wordApi}) : _wordApi = wordApi;

  final WordApi _wordApi;

  Future<List<Word>> getAllWords() => _wordApi.getAllWords();

  Future<List<Word>> getWords({required AddedBy addedBy}) =>
      _wordApi.getWords(addedBy: addedBy);

  Future<void> fetchFromJson({required AddedBy addedBy}) =>
      _wordApi.fetchFromJson(addedBy: addedBy);

  Future<void> add({required Word word}) => _wordApi.add(word: word);

  Future<void> remove({required AddedBy addedBy, required int id}) =>
      _wordApi.remove(addedBy: addedBy, id: id);

  Future<void> clear({AddedBy? addedBy}) => _wordApi.clear(addedBy: addedBy);

  Future<void> update({required Word word}) => _wordApi.update(word: word);
}
