// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'add_word_state.dart';

class AddWordCubit extends Cubit<AddWordState> {
  AddWordCubit(this.repository) : super(AddWordInitial());

  final WordRepository repository;

  void addWord(Word word) async {
    await repository.add(word);
  }
}
