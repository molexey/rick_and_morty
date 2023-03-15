import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
//import 'package:src/network/api/characteres/data/response_info_dto.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';

part 'characters_response_dto.g.dart';

@JsonSerializable()
class CharactersResponseDto {
  @JsonKey(name: 'results')
  final List<CharacterEntity> items;
  final ResponseInfoDto info;

  const CharactersResponseDto({
    required this.items,
    required this.info,
  });

  factory CharactersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CharactersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersResponseDtoToJson(this);
}
