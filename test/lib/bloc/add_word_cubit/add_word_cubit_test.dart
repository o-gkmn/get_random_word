import 'package:flutter_test/flutter_test.dart';
import 'package:get_random_word/bloc/add_word_cubit/add_word_cubit.dart';
import 'package:word_repository/word_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../packages/word_repository/word_repository_test.dart';
import '../../../packages/word_repository/word_repository_test.mocks.dart';

void main() {
  group("AddWordCubit test", () {
    late AddWordCubit addWordCubit;
    MockMockWordApi mockApi;
    WordRepository testRepo;

    setUp(() {
      mockApi = MockMockWordApi();
      testRepo = WordRepository(wordApi: mockApi);
      addWordCubit = AddWordCubit(testRepo);
      when(testRepo.getWords()).thenAnswer((_) async => words);
      when(testRepo.add(word))
          .thenAnswer((realInvocation) async => words.add(word));
    });

    test("=>addWord test passed", () async {
      List<Word> oldWords = await addWordCubit.repository.getWords();
      int length = oldWords.length;

      addWordCubit.addWord(word);

      oldWords = await addWordCubit.repository.getWords();

      expect(oldWords.length, length + 1);
    });

    tearDown(() {
      addWordCubit.close();
    });
  });
}
