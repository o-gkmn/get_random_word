// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      id: json['id'] as int,
      englishWord: json['englishWord'] as String,
      turkishWord: json['turkishWord'] as String,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'englishWord': instance.englishWord,
      'turkishWord': instance.turkishWord,
    };
