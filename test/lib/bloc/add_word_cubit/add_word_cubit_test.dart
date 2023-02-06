import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_random_word/bloc/add_word_cubit/add_word_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:word_repository/word_repository.dart';

class MockWordRepository extends Mock implements WordRepository {}

void main() {
  late AddWordCubit addWordCubit;
  late MockWordRepository mockWordRepository;

  setUp(() {
    mockWordRepository = MockWordRepository();
    addWordCubit = AddWordCubit(mockWordRepository);
  });

  group("AddWordCubit test", () {
    Exception tex = Exception();
    Word word = const Word(
        id: 0, englishWord: "englishWord", turkishWord: "turkishWord");

    test("=>addWord test passed", () async {
      List<Word> oldWords = await addWordCubit.repository.getWords();
      int length = oldWords.length;

      addWordCubit.addWord(word);

      oldWords = await addWordCubit.repository.getWords();

      expect(oldWords.length, length + 1);
    });

    blocTest(
      "emits [AddWordStatus.succes] when addWord is called succesfully",
      setUp: () {
        when(() => mockWordRepository.add(word)).thenThrow(tex);
      },
      build: () => addWordCubit,
      act: (bloc) => addWordCubit.addWord(word),
      expect: () =>
          [AddWordState(status: AddWordStatus.failed, exception: tex)],
      verify: (bloc) {
        verify(() => mockWordRepository.add(word)).called(1);
      },
    );

    tearDown(() {
      addWordCubit.close();
    });
  });
}
