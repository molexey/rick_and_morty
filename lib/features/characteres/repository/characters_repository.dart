import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';

abstract class ICharactersRepository {
  bool get hasMorePage;
  Future<List<CharacterEntity>?> getCharacters(bool refresh);
}