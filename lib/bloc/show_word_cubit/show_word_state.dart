part of 'show_word_cubit.dart';

enum Button { englishWordButton, turkishWordButton }

abstract class ShowWordState extends Equatable {
  const ShowWordState(
      {this.englishWord_ = "İngilizce Kelime",
      this.turkishWord_ = "Türkçe Kelime",
      this.englishState_ = false,
      this.turkishState_ = false});

  final String englishWord_;
  final String turkishWord_;

  final bool englishState_;
  final bool turkishState_;

  @override
  List<Object> get props =>
      [englishWord_, turkishWord_, englishState_, turkishState_];
}

class ShowWordLoaded extends ShowWordState {
  const ShowWordLoaded(
      {required this.englishWord,
      required this.turkishWord,
      required this.englishState,
      required this.turkishState})
      : super(
            englishWord_: englishWord,
            turkishWord_: turkishWord,
            englishState_: englishState,
            turkishState_: turkishState);

  final String englishWord;
  final String turkishWord;

  final bool englishState;
  final bool turkishState;

  @override
  List<Object> get props =>
      [englishWord, turkishWord, englishState, turkishState];
}

class ShowWordError extends ShowWordState {
  final String e;

  const ShowWordError(this.e);

  @override
  List<Object> get props => [e];
}
