import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:word_api/word_api.dart';
import 'package:word_repository/word_repository.dart';
import 'package:mockito/mockito.dart';

import 'word_repository_test.mocks.dart';

Word word = const Word(id: 0, englishWord: "engg", turkishWord: "turkishWord_");

List<Word> words = [
  const Word(id: 0, englishWord: "englishWord_", turkishWord: "turkishWord_")
];

class MockWordApi extends Mock implements WordApi {}

@GenerateMocks([MockWordApi])
void main() {
  group("Repository Test", () {
    late WordRepository repos;
    MockMockWordApi testApi;

    setUp(() {
      testApi = MockMockWordApi();
      repos = WordRepository(wordApi: testApi);
      when(testApi.getWords()).thenAnswer((_) async => words);
      when(testApi.add(word)).thenAnswer((_) async => words.add(word));
    });

    test("=> getWords test", () async {
      List<Word> words = await repos.getWords();

      expect(words, const [
        Word(id: 0, englishWord: "englishWord_", turkishWord: "turkishWord_")
      ]);
    });

    test("=>add test", () async {
      int length = words.length;

      await repos.add(word);

      expect(words.length, length + 1);
    });
  });
}
