import 'package:core/core.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';
import 'package:rick_and_morty/features/characteres/repository/characters_repository.dart';

class CharactersRepositoryRemote implements ICharactersRepository {
  final _charactersApi = CharactersApi();

  int _pageForRequest = 1;
  static bool _hasMorePage = true;

  bool get hasMorePage => _hasMorePage;

  final List<CharacterEntity> _characters = [];

  @override
  Future<List<CharacterEntity>?> getCharacters(bool refresh) async {
    if (refresh) {
      _pageForRequest = 1;
      _characters.clear();
    }
    print('!!! 2 getCharacters() _pageForRequest $_pageForRequest');
    try {
      final result = await _charactersApi.getCharacters(page: _pageForRequest);
      if (result?.items != null) {
        _pageForRequest++;
        _hasMorePage = _pageForRequest < (result?.info.pages ?? 0);
        _characters.addAll(result!.items);
        return _characters;
      }
      return result?.items;
    } catch (error) {
      return null;
    }
  }
}
