import 'package:get_random_word/models/model_constant.dart';

class Words {
  int? id;
  late String englishWord;
  late String turkishWord;

  Words(this.id, this.englishWord, this.turkishWord);
  Words.withoutId(this.englishWord, this.turkishWord);
  Words.empty();

  Words.fromObject(dynamic o) {
    id = int.tryParse(o[columnId].toString())!;
    englishWord = o[columnEnglish];
    turkishWord = o[columnTurkish];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[columnEnglish] = englishWord;
    map[columnTurkish] = turkishWord;

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
