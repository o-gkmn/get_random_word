part of 'add_word_cubit.dart';

enum AddWordStatus { initial, succes, failed }

class AddWordState extends Equatable {
  const AddWordState(
      {required this.status, this.word = const Word.empty(), this.exception});

  final AddWordStatus status;
  final Exception? exception;
  final Word word;

  AddWordState copyWith(
      {AddWordStatus? status, Word? word, Exception? exception}) {
    return AddWordState(
        status: status ?? this.status,
        word: word ?? this.word,
        exception: exception ?? this.exception);
  }

  @override
  List<Object> get props => [status];
}
