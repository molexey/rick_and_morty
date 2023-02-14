import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/characteres/entity/character_location_entity.dart';

part 'character_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterLocationEntity origin;
  final CharacterLocationEntity location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);
}
