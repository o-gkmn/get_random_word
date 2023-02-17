import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

enum AddedBy { system, user }

@JsonSerializable()
class Word extends Equatable {
  final int id;
  final String englishWord;
  final String turkishWord;
  final AddedBy addedBy;

  const Word(
      {required this.id,
      required this.englishWord,
      required this.turkishWord,
      required this.addedBy});

  const Word.empty(
      {this.id = -1,
      this.englishWord = "",
      this.turkishWord = "",
      this.addedBy = AddedBy.user});

  Word copyWith(
      {int? id, String? englishWord, String? turkishWord, AddedBy? addedBy}) {
    return Word(
      id: id ?? this.id,
      englishWord: englishWord ?? this.englishWord,
      turkishWord: turkishWord ?? this.turkishWord,
      addedBy: addedBy ?? this.addedBy,
    );
  }

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

  @override
  List<Object?> get props => [id, englishWord, turkishWord];
}
