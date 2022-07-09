import 'package:get_random_word/data/db_helper.dart';
import 'package:get_random_word/models/words.dart';

class WordService {
  var dbHelper = DbHelper();

  static final WordService _singleton = WordService._internal();

  WordService._internal();

  factory WordService() {
    return _singleton;
  }

  Future<List<Words>> getWords() async {
    List<Words> list = <Words>[];
    var wordsFuture = await dbHelper.getWords();
    list = wordsFuture.cast();
    return list;
  }

  void add(Words word) async {
    await dbHelper.insert(word);
  }

  void remove(int id) async {
    await dbHelper.delete(id);
  }

  void update(Words word) async {
    await dbHelper.update(word);
  }
}
