import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_random_word/bloc/show_word_cubit/show_word_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:word_repository/word_repository.dart';

import '../../../packages/word_repository/word_repository_test.dart';
import '../../../packages/word_repository/word_repository_test.mocks.dart';

void main() {
  group("showWordCubit Test", () {
    late ShowWordCubit showWordCubit;
    WordRepository testRepository;
    MockMockWordApi testApi;

    setUp(() {
      EquatableConfig.stringify = true;
      testApi = MockMockWordApi();
      testRepository = WordRepository(wordApi: testApi);
      showWordCubit = ShowWordCubit(testRepository);
      when(testRepository.getWords()).thenAnswer((_) async => words);
    });

    test("=> InitialRandomWord => Random Word is initialized", () async {
      await showWordCubit.initialRandomWord();
      expect(showWordCubit.randomWord, words[0]);
    });

    blocTest<ShowWordCubit, ShowWordState>(
      "=> GetRandomWord => English  word is initialized but turkish word isnt initialized",
      build: () => showWordCubit,
      act: (bloc) => showWordCubit.getRandomWord(
          Button.englishWordButton,
          const ShowWordLoaded(
              englishWord: "İngilizce Kelime",
              turkishWord: "Türkçe Kelime",
              englishState: false,
              turkishState: false)),
      expect: () => const [
        ShowWordLoaded(
            englishWord: "englishWord_",
            turkishWord: "Türkçe Kelime",
            englishState: true,
            turkishState: false)
      ],
    );

    blocTest<ShowWordCubit, ShowWordState>(
      "=> GetRandomWord => Turkish word is initialized but engish word isnt initialized",
      build: () => showWordCubit,
      act: (bloc) => showWordCubit.getRandomWord(
          Button.turkishWordButton,
          const ShowWordLoaded(
              englishWord: "İngilizce Kelime",
              turkishWord: "Türkçe Kelime",
              englishState: false,
              turkishState: false)),
      expect: () => const [
        ShowWordLoaded(
            englishWord: "İngilizce Kelime",
            turkishWord: "turkishWord_",
            englishState: false,
            turkishState: true)
      ],
    );

    blocTest<ShowWordCubit, ShowWordState>(
      "=> GetRandomWord => Both word state is true",
      build: () => showWordCubit,
      act: (bloc) {
        showWordCubit.getRandomWord(
            Button.turkishWordButton,
            const ShowWordLoaded(
                englishWord: "englishWord_",
                turkishWord: "turkishWord_",
                englishState: true,
                turkishState: true));
      },
      expect: () => const [
        ShowWordLoaded(
            englishWord: "İngilizce Kelime",
            turkishWord: "turkishWord_",
            englishState: false,
            turkishState: true)
      ],
    );

    tearDown(() {
      showWordCubit.close();
    });
  });
}
