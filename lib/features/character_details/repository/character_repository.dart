import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';

abstract class ICharacterRepository {
  Future<CharacterEntity?> getCharacter(int id);
}

