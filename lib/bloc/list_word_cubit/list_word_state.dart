part of 'list_word_cubit.dart';

enum ListStatus { initial, succed, failure, empty }

class ListWordState extends Equatable {
  const ListWordState(
      {required this.status, this.words = const <Word>[], this.exception});

  final ListStatus status;
  final List<Word> words;
  final Exception? exception;

  ListWordState copyWith(
      {ListStatus? status, List<Word>? words, Exception? exception}) {
    return ListWordState(
        status: status ?? this.status,
        words: words ?? this.words,
        exception: exception ?? this.exception);
  }

  @override
  List<Object> get props => [status, words];
}
