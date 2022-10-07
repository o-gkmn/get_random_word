import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'show_word_state.dart';

class ShowWordCubit extends Cubit<ShowWordState> {
  ShowWordCubit(this.wordRepository)
      : super(const ShowWordLoaded(
            englishWord: "İngilizce Kelime",
            turkishWord: "Türkçe Kelime",
            englishState: false,
            turkishState: false));

  late Word randomWord;

  final WordRepository wordRepository;

  Future<Word> initialRandomWord() async {
    Random random = Random();
    List<Word> words = await wordRepository.getWords();
    if (words.isEmpty) {
      emit(const ShowWordError(
          "Kelime listeniz boş. Lütfen önce kelime ekleyin"));
    }
    randomWord = words.elementAt(random.nextInt(words.length));
    return randomWord;
  }

  void emitLoadedState() {
    emit(const ShowWordLoaded(
        englishWord: "İngilizce Kelime",
        turkishWord: "Türkçe Kelime",
        englishState: false,
        turkishState: false));
  }

  void getRandomWord(Button button, ShowWordState state) async {
    if (state is ShowWordLoaded) {
      if ((state.englishState && state.turkishState) ||
          (!state.englishState && !state.turkishState)) {
        await initialRandomWord();
        if (button == Button.englishWordButton) {
          emit(ShowWordLoaded(
              englishWord: randomWord.englishWord,
              turkishWord: "Çeviri için tıklaıyn",
              englishState: true,
              turkishState: false));
        } else if (button == Button.turkishWordButton) {
          emit(ShowWordLoaded(
              englishWord: "Çeviri için tıklaıyn",
              turkishWord: randomWord.turkishWord,
              englishState: false,
              turkishState: true));
        }
      } else if (!state.englishState && state.turkishState) {
        if (button == Button.englishWordButton) {
          emit(ShowWordLoaded(
              englishWord: randomWord.englishWord,
              turkishWord: state.turkishWord,
              englishState: true,
              turkishState: true));
        } else if (button == Button.turkishWordButton) {
          await initialRandomWord();
          emit(ShowWordLoaded(
              englishWord: "Çeviri için tıklaıyn",
              turkishWord: randomWord.turkishWord,
              englishState: false,
              turkishState: true));
        }
      } else if (state.englishState && !state.turkishState) {
        if (button == Button.englishWordButton) {
          await initialRandomWord();
          emit(ShowWordLoaded(
              englishWord: randomWord.englishWord,
              turkishWord: "Çeviri için tıklaıyn",
              englishState: true,
              turkishState: false));
        } else if (button == Button.turkishWordButton) {
          emit(ShowWordLoaded(
              englishWord: state.englishWord,
              turkishWord: randomWord.turkishWord,
              englishState: true,
              turkishState: true));
        }
      }
    }
  }
}
