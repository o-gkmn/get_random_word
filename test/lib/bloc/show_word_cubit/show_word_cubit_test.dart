import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_random_word/bloc/show_word_cubit/show_word_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:word_repository/word_repository.dart';

class MockWordRepository extends Mock implements WordRepository {}

void main() {
  group("showWordCubit Test", () {
    late ShowWordCubit showWordCubit;
    late MockWordRepository mockWordRepository;

    const List<Word> words = [
      Word(id: 0, englishWord: "englishWord_", turkishWord: "turkishWord_"),
      Word(id: 1, englishWord: "english", turkishWord: "turkish"),
      Word(id: 2, englishWord: "eng", turkishWord: "tur"),
      Word(id: 3, englishWord: "en", turkishWord: "tr"),
    ];

    Exception exception = Exception();

    setUp(() {
      mockWordRepository = MockWordRepository();
      showWordCubit = ShowWordCubit(mockWordRepository);
    });

    group("initialRandomWordList", () {
      blocTest(
        "emits [PageStatus.loading, PageStatus.loaded] when initialRandomWordList called is succesfully",
        setUp: () => when(() => mockWordRepository.getWords())
            .thenAnswer((_) async => words),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.initialRandomWordList(),
        expect: () => <ShowWordState>[
          const ShowWordState(pageStatus: PageStatus.loading),
          const ShowWordState(pageStatus: PageStatus.loaded)
        ],
        verify: (bloc) {
          verify(() => mockWordRepository.getWords()).called(1);
        },
      );

      blocTest(
        "emits [PageStatus.loading, PageStatus.error] when initialRandomWordList is faliure",
        setUp: () =>
            when(() => mockWordRepository.getWords()).thenThrow(exception),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.initialRandomWordList(),
        expect: () => <ShowWordState>[
          const ShowWordState(pageStatus: PageStatus.loading),
          ShowWordState(pageStatus: PageStatus.error, exception: exception),
        ],
        verify: (bloc) {
          verify(() => mockWordRepository.getWords()).called(1);
        },
      );
    });

    group("generateRandomWord", () {
      setUp(() => showWordCubit.words = words);
      test("generateRandomWord", () {
        expect(showWordCubit.generateRandomWord(), isA<Word>());
        expect(showWordCubit.randomWord, showWordCubit.generateRandomWord());
      });

      blocTest(
        "emits [PageStatus.error] when initialRandomWordList is succesfully but showWordList is empty",
        setUp: () => showWordCubit.words = <Word>[],
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.generateRandomWord(),
        expect: () => <ShowWordState>[
          ShowWordState(pageStatus: PageStatus.error, exception: exception),
        ],
      );
    });

    group("emitOpenEnglishWord", () {
      setUp(() => showWordCubit.words = words);
      blocTest(
        "emits [WordStatus.openEnglishWord] when emitOpenEnglishWord called is succesfully",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => const ShowWordState(pageStatus: PageStatus.loaded),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitOpenEnglishWord(),
        expect: () => <ShowWordState>[
          ShowWordState(
              pageStatus: PageStatus.loaded,
              wordStatus: WordStatus.openEnglishWord,
              englishWord: showWordCubit.randomWord.englishWord,
              turkishWord: "Çeviri için Tıklayınız"),
        ],
      );

      blocTest(
        "emits [WordStatus.bothOpen] when emitOpenEnglishWord called is succesfully but WordStatus is WordStatus.openTurkishWord",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => ShowWordState(
            pageStatus: PageStatus.loaded,
            wordStatus: WordStatus.openTurkishWord,
            turkishWord: showWordCubit.randomWord.turkishWord,
            englishWord: "Çeviri için Tıklayınız"),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitOpenEnglishWord(),
        expect: () => <ShowWordState>[
          ShowWordState(
              pageStatus: PageStatus.loaded,
              wordStatus: WordStatus.bothOpen,
              englishWord: showWordCubit.randomWord.englishWord,
              turkishWord: showWordCubit.randomWord.turkishWord),
        ],
      );

      blocTest(
        "emits [WordStatus.openEnglishWord] when emitOpenEnglishWord called is succesfully while WordStatus is WordStatus.openEnglishWord",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => ShowWordState(
          pageStatus: PageStatus.loaded,
          wordStatus: WordStatus.openEnglishWord,
          englishWord: showWordCubit.randomWord.englishWord,
          turkishWord: "Çeviri için Tıklayınız",
        ),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitOpenEnglishWord(),
        expect: () => <ShowWordState>[
          ShowWordState(
              pageStatus: PageStatus.loaded,
              wordStatus: WordStatus.openEnglishWord,
              englishWord: showWordCubit.randomWord.englishWord,
              turkishWord: "Çeviri için Tıklayınız"),
        ],
      );
    });

    group("emitOpenTurkishWord", () {
      setUp(() => showWordCubit.words = words);
      blocTest(
        "emits [WordStatus.openTurkishWord] when emitOpenTurkishWord called is succesfully",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => const ShowWordState(pageStatus: PageStatus.loaded),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitOpenTurkishWord(),
        expect: () => <ShowWordState>[
          ShowWordState(
            pageStatus: PageStatus.loaded,
            wordStatus: WordStatus.openTurkishWord,
            englishWord: "Çeviri için Tıklayınız",
            turkishWord: showWordCubit.randomWord.turkishWord,
          ),
        ],
      );

      blocTest(
        "emits [WordStatus.bothOpen] when emitOpenTurkishWord called is succesfully but WordStatus is WordStatus.openEnglishWord",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => ShowWordState(
            pageStatus: PageStatus.loaded,
            wordStatus: WordStatus.openEnglishWord,
            turkishWord: "Çeviri için Tıklayınız",
            englishWord: showWordCubit.randomWord.englishWord),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitOpenTurkishWord(),
        expect: () => <ShowWordState>[
          ShowWordState(
              pageStatus: PageStatus.loaded,
              wordStatus: WordStatus.bothOpen,
              englishWord: showWordCubit.randomWord.englishWord,
              turkishWord: showWordCubit.randomWord.turkishWord),
        ],
      );

      blocTest(
        "emits [WordStatus.openTurkishWord] when emitOpenTurkishWord called is succesfully while WordStatus is WordStatus.openTurkishWord",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => ShowWordState(
            pageStatus: PageStatus.loaded,
            wordStatus: WordStatus.openTurkishWord,
            turkishWord: showWordCubit.randomWord.turkishWord,
            englishWord: "Çeviri için Tıklayınız"),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitOpenTurkishWord(),
        expect: () => <ShowWordState>[
          ShowWordState(
              pageStatus: PageStatus.loaded,
              wordStatus: WordStatus.openTurkishWord,
              englishWord: "Çeviri için Tıklayınız",
              turkishWord: showWordCubit.randomWord.turkishWord),
        ],
      );
    });

    group("emitBothOpen", () {
      setUp(() => showWordCubit.words = words);

      blocTest(
        "emits [WordStatus.bothOpen] when emitBothOpen is called succesfully with WordStatus.openEnglishWord",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => ShowWordState(
            pageStatus: PageStatus.loaded,
            wordStatus: WordStatus.openEnglishWord,
            englishWord: showWordCubit.randomWord.englishWord,
            turkishWord: "Çeviri için Tıklayınız"),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitBothOpen(),
        expect: () => <ShowWordState>[
          ShowWordState(
              pageStatus: PageStatus.loaded,
              wordStatus: WordStatus.bothOpen,
              englishWord: showWordCubit.randomWord.englishWord,
              turkishWord: showWordCubit.randomWord.turkishWord)
        ],
      );

      blocTest(
        "emits [WordStatus.bothOpen] when emitBothOpen is called succesfully with WordStatus.openTurkishWord",
        setUp: () => when(() =>
            showWordCubit.randomWord = showWordCubit.generateRandomWord()),
        seed: () => ShowWordState(
            pageStatus: PageStatus.loaded,
            wordStatus: WordStatus.openTurkishWord,
            englishWord: "Çeviri için Tıklayınız",
            turkishWord: showWordCubit.randomWord.turkishWord),
        build: () => showWordCubit,
        act: (bloc) => showWordCubit.emitBothOpen(),
        expect: () => <ShowWordState>[
          ShowWordState(
              pageStatus: PageStatus.loaded,
              wordStatus: WordStatus.bothOpen,
              englishWord: showWordCubit.randomWord.englishWord,
              turkishWord: showWordCubit.randomWord.turkishWord)
        ],
      );
    });
  });
}
