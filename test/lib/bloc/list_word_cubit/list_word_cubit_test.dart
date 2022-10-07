import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_random_word/bloc/list_word_cubit/list_word_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:word_repository/word_repository.dart';

import '../../../packages/word_repository/word_repository_test.dart';
import '../../../packages/word_repository/word_repository_test.mocks.dart';

void main() {
  late ListWordCubit listWordCubit;
  MockMockWordApi mockApi;
  WordRepository testRepo;

  group("ListWordCubit test", () {
    setUp(() {
      EquatableConfig.stringify = true;
      mockApi = MockMockWordApi();
      testRepo = WordRepository(wordApi: mockApi);
      listWordCubit = ListWordCubit(testRepo);
      when(testRepo.getWords()).thenAnswer((_) async => words);
    });

    blocTest<ListWordCubit, ListWordState>("=>List Word initialized",
        build: () => listWordCubit,
        act: (bloc) => listWordCubit.initialListWord(),
        expect: () => [ListWordLoaded(words: words)]);

    tearDown(() {
      listWordCubit.close();
    });
  });
}
