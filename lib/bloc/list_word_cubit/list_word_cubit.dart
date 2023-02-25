// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_repository/word_repository.dart';

part 'list_word_state.dart';

class ListWordCubit extends Cubit<ListWordState> {
  ListWordCubit(this.repository)
      : super(const ListWordState(status: ListStatus.initial));

  final WordRepository repository;
  late StreamSubscription<List<Word>> streamSubscription;

  void initialListWord() async {
    try {
      streamSubscription = repository.listenWordsList().listen((words) {
        if (words.isEmpty) {
          emit(state.copyWith(status: ListStatus.empty));
        } else {
          emit(state.copyWith(status: ListStatus.succed, words: words));
        }
      });
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.failure, exception: e as Exception));
      return;
    }
  }

  @override
  Future<void> close() async {
    await streamSubscription.cancel();
    return super.close();
  }
}
