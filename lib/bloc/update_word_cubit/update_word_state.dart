part of 'update_word_cubit.dart';

enum UpdateStatus { inital, succed, failure }

class UpdateWordState extends Equatable {
  const UpdateWordState(
      {required this.status, this.word = const Word.empty(), this.exception});

  final UpdateStatus status;
  final Word word;
  final Exception? exception;

  UpdateWordState copyWith(
      {UpdateStatus? status, Word? word, Exception? exception}) {
    return UpdateWordState(
        status: status ?? this.status,
        word: word ?? this.word,
        exception: exception ?? this.exception);
  }

  @override
  List<Object> get props => [status, word];
}
