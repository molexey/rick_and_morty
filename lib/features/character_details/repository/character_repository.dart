import 'package:rick_and_morty/api/characteres/characteres_api.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';

class CharacterResository {
  final _charactersApi = CharactersApi();

  Future<CharacterEntity?> getCharacter(int id) async {
    try {
      final result = await _charactersApi.getCharacter(id: id);
      if (result != null) {
        return result;
      }
      return result;
    } catch (error) {
      return null;
    }
  }
}