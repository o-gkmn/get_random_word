// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      id: json['id'] as int,
      englishWord: json['englishWord'] as String,
      turkishWord: json['turkishWord'] as String,
      addedBy: $enumDecode(_$AddedByEnumMap, json['addedBy']),
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'id': instance.id,
      'englishWord': instance.englishWord,
      'turkishWord': instance.turkishWord,
      'addedBy': _$AddedByEnumMap[instance.addedBy]!,
    };

const _$AddedByEnumMap = {
  AddedBy.smallPack: 'smallPack',
  AddedBy.mediumPack: 'mediumPack',
  AddedBy.largePack: 'largePack',
  AddedBy.user: 'user',
};
