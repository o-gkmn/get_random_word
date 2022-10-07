// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'list_word_state.dart';

class ListWordCubit extends Cubit<ListWordState> {
  ListWordCubit(this.repository) : super(ListWordInitial()) {
    initialListWord();
  }

  final WordRepository repository;

  void initialListWord() async {
    List<Word> words = await repository.getWords();
    if (words.isEmpty) {
      emit(ListWordEmpty());
    } else {
      emit(ListWordLoaded(words: words));
    }
  }
}
