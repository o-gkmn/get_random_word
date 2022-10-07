import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_random_word/bloc/update_word_cubit/update_word_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:word_repository/word_repository.dart';

import '../../../packages/word_repository/word_repository_test.dart';
import '../../../packages/word_repository/word_repository_test.mocks.dart';

void main() {
  group("UpdateWordCubit test", () {
    late UpdateWordCubit updateWordCubit;
    WordRepository testRepo;
    MockMockWordApi mockApi;

    setUp(() {
      mockApi = MockMockWordApi();
      testRepo = WordRepository(wordApi: mockApi);
      updateWordCubit = UpdateWordCubit(testRepo, words[0]);
      when(testRepo.update(word)).thenAnswer(
          (_) async => word = word.copyWith(englishWord: "englishWord_"));
      when(testRepo.remove(0)).thenAnswer((_) async => words.removeAt(0));
    });

    blocTest<UpdateWordCubit, UpdateWordState>("emit LoadedState",
        build: () => updateWordCubit,
        act: (bloc) => updateWordCubit.emitLoadedState(),
        expect: () => [UpdateWordLoaded(updateWordCubit.word)]);

    test("=> updateWord test", () {
      updateWordCubit.updateWord(word);
      expect(words[0], word);
    });

    test("=> deleteWord", () {
      updateWordCubit.deleteWord(0);
      expect(0, words.length);
    });
  });
}
