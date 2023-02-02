import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_random_word/bloc/list_word_cubit/list_word_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:word_repository/word_repository.dart';

class MockWordRepository extends Mock implements WordRepository {}

void main() {
  late ListWordCubit listWordCubit;
  late MockWordRepository mockWordRepository;

  setUp(() {
    mockWordRepository = MockWordRepository();
    listWordCubit = ListWordCubit(mockWordRepository);
  });

  group("initialListWord", () {
    const List<Word> words = [
      Word(id: 0, englishWord: "englishWord_", turkishWord: "turkishWord_")
    ];

    const List<Word> emptyWords = [];
    Exception texception = Exception();

    blocTest<ListWordCubit, ListWordState>(
      "emits [ListStatus.succed] when initialListWord is called succesfully",
      setUp: () => when(() => mockWordRepository.getWords())
          .thenAnswer((invocation) async => words),
      build: () => listWordCubit,
      act: (cubit) => cubit.initialListWord(),
      expect: () =>
          [const ListWordState(status: ListStatus.succed, words: words)],
      verify: (cubit) {
        verify(() => mockWordRepository.getWords()).called(1);
      },
    );

    blocTest(
      "emits [ListStatus.empty] when initialListWord is called succesfully",
      setUp: () => when(() => mockWordRepository.getWords())
          .thenAnswer((invocation) async => emptyWords),
      build: () => listWordCubit,
      act: (cubit) => listWordCubit.initialListWord(),
      expect: () =>
          <ListWordState>[const ListWordState(status: ListStatus.empty)],
      verify: (bloc) {
        verify(() => mockWordRepository.getWords()).called(1);
      },
    );

    blocTest(
      "emits [ListStatus.failure] when initialListWord is failure",
      setUp: () =>
          when(() => mockWordRepository.getWords()).thenThrow(texception),
      build: () => listWordCubit,
      act: (cubit) => listWordCubit.initialListWord(),
      expect: () => <ListWordState>[
        ListWordState(status: ListStatus.failure, exception: texception)
      ],
      verify: (bloc) {
        verify(() => mockWordRepository.getWords()).called(1);
      },
    );
  });
  tearDown(() {
    listWordCubit.close();
  });
}
