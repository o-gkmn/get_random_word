part of 'list_word_cubit.dart';

abstract class ListWordState extends Equatable {
  const ListWordState();

  @override
  List<Object> get props => [];
}

class ListWordInitial extends ListWordState {}

class ListWordLoaded extends ListWordState {
  final List<Word> words;

  const ListWordLoaded({required this.words});

  @override
  List<Object> get props => [words];
}

class ListWordEmpty extends ListWordState {}
