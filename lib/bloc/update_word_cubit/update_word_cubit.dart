import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'update_word_state.dart';

class UpdateWordCubit extends Cubit<UpdateWordState> {
  UpdateWordCubit(this.repository, this.word)
      : super(UpdateWordState(status: UpdateStatus.inital, word: word));

  final WordRepository repository;
  final Word word;

  void updateWord(Word word) async {
    try {
      await repository.update(word);
      emit(state.copyWith(status: UpdateStatus.succed));
    } catch (e) {
      emit(state.copyWith(
          status: UpdateStatus.failure, exception: e as Exception));
    }
  }

  void deleteWord(int id) async {
    try {
      await repository.remove(id);
      emit(state.copyWith(status: UpdateStatus.succed));
    } catch (e) {
      emit(state.copyWith(
          status: UpdateStatus.failure, exception: e as Exception));
    }
  }
}
