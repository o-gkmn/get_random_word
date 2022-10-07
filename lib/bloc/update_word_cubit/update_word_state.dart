part of 'update_word_cubit.dart';

abstract class UpdateWordState extends Equatable {
  const UpdateWordState({this.word = const Word.empty()});

  final Word word;

  @override
  List<Object> get props => [word];
}

class UpdateWordInitial extends UpdateWordState {}

class UpdateWordLoaded extends UpdateWordState {
  final Word word_;

  const UpdateWordLoaded(this.word_) : super(word: word_);

  @override
  List<Object> get props => [word_];
}
