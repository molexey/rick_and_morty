import 'package:json_annotation/json_annotation.dart';

part 'character_location_entity.g.dart';

@JsonSerializable()
class CharacterLocationEntity {
  final String name;
  final String url;

  const CharacterLocationEntity({
    required this.name,
    required this.url,
  });

  factory CharacterLocationEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterLocationEntityToJson(this);
}
