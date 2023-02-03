import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'show_word_state.dart';

class ShowWordCubit extends Cubit<ShowWordState> {
  ShowWordCubit(this.wordRepository)
      : super(const ShowWordState(
            pageStatus: PageStatus.initial, wordStatus: WordStatus.bothClose));

  late Word randomWord;
  late List<Word> words;

  final WordRepository wordRepository;

  void initialRandomWordList() async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      words = await wordRepository.getWords();
      emit(state.copyWith(pageStatus: PageStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
          pageStatus: PageStatus.error, exception: e as Exception));
    }
  }

  Word generateRandomWord() {
    Random random = Random();
    if (words.isEmpty) {
      emit(state.copyWith(
          pageStatus: PageStatus.error,
          exception:
              Exception("Kelime listeniz boş. Lütfen önce kelime ekleyin")));
      return const Word.empty();
    }
    randomWord = words.elementAt(random.nextInt(words.length));
    return randomWord;
  }

  void emitOpenEnglishWord() {
    checkStatus();
    if (state.wordStatus == WordStatus.openTurkishWord) {
      emitBothOpen();
      return;
    }
    if (state.wordStatus == WordStatus.openEnglishWord) {
      generateRandomWord();
    }
    emit(state.copyWith(
        wordStatus: WordStatus.openEnglishWord,
        englishWord: randomWord.englishWord,
        turkishWord: "Çeviri için Tıklayınız"));
  }

  void emitOpenTurkishWord() {
    checkStatus();
    if (state.wordStatus == WordStatus.openEnglishWord) {
      emitBothOpen();
      return;
    }
    if(state.wordStatus == WordStatus.openTurkishWord){
      generateRandomWord();
    }
    emit(state.copyWith(
        wordStatus: WordStatus.openTurkishWord,
        turkishWord: randomWord.turkishWord,
        englishWord: "Çeviri için Tıklayınız"));
  }

  void emitBothOpen() => emit(state.copyWith(
      wordStatus: WordStatus.bothOpen,
      englishWord: randomWord.englishWord,
      turkishWord: randomWord.turkishWord));

  void checkStatus() {
    if (state.wordStatus == WordStatus.bothOpen ||
        state.wordStatus == WordStatus.bothClose) {
      generateRandomWord();
    }
  }
}
