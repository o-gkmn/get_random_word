// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'update_word_state.dart';

class UpdateWordCubit extends Cubit<UpdateWordState> {
  UpdateWordCubit(this.repository, this.word) : super(UpdateWordInitial()) {
    emitLoadedState();
  }

  final WordRepository repository;
  final Word word;

  void emitLoadedState() => emit(UpdateWordLoaded(word));

  void updateWord(Word word) async {
    await repository.update(word);
  }

  void deleteWord(int id) async {
    await repository.remove(id);
  }
}
