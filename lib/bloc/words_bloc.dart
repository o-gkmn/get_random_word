import 'package:get_random_word/data/words_service.dart';

import '../models/words.dart';

class WordsBloc {
  static var words = <Words>[];

  static Future<List<Words>> getWords() {
    return WordService().getWords();
  }

  static void add(Words word) {
    WordService().add(word);
    initialWords();
  }

  static void remove(int id) {
    WordService().remove(id);
    initialWords();
  }

  static void update(Words word) {
    WordService().update(word);
    initialWords();
  }

  static Future<List<Words>> initialWords() async {
    var wordsFuture = await getWords();
    words = wordsFuture.cast();
    return words;
  }
}

final wordBloc = WordsBloc();
