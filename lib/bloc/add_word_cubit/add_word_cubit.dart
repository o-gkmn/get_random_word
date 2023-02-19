import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'add_word_state.dart';

class AddWordCubit extends Cubit<AddWordState> {
  AddWordCubit(this.repository)
      : super(const AddWordState(status: AddWordStatus.initial));

  final WordRepository repository;

  void addWord(Word word) async {
    try {
      await repository.add(word: word);
      emit(state.copyWith(status: AddWordStatus.succes));
    } catch (e) {
      emit(AddWordState(
          status: AddWordStatus.failed, exception: e as Exception));
    }
  }
}
