// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersResponseDto _$CharactersResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CharactersResponseDto(
      items: (json['results'] as List<dynamic>)
          .map((e) => CharacterEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: ResponseInfoDto.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharactersResponseDtoToJson(
        CharactersResponseDto instance) =>
    <String, dynamic>{
      'results': instance.items,
      'info': instance.info,
    };
