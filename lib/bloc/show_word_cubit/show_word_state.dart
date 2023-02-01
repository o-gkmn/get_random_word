part of 'show_word_cubit.dart';

enum WordStatus { openEnglishWord, openTurkishWord, bothOpen, bothClose }

enum PageStatus { initial, loading, loaded, error }

class ShowWordState extends Equatable {
  const ShowWordState({
    required this.pageStatus,
    this.wordStatus = WordStatus.bothClose,
    this.englishWord = "İngilizce Kelime",
    this.turkishWord = "Türkçe Kelime",
    this.exception,
  });

  final PageStatus pageStatus;
  final WordStatus wordStatus;
  final String englishWord;
  final String turkishWord;
  final Exception? exception;

  ShowWordState copyWith(
      {PageStatus? pageStatus,
      WordStatus? wordStatus,
      String? englishWord,
      String? turkishWord,
      Exception? exception}) {
    return ShowWordState(
      pageStatus: pageStatus ?? this.pageStatus,
      wordStatus: wordStatus ?? this.wordStatus,
      englishWord: englishWord ?? this.englishWord,
      turkishWord: turkishWord ?? this.turkishWord,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object> get props => [pageStatus, wordStatus, englishWord, turkishWord];
}
