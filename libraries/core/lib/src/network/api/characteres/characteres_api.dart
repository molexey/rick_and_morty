import 'package:dio/dio.dart';
import 'package:core/core.dart';
//import 'package:rick_and_morty/api/characteres/data/characters_response_dto.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';

class CharactersApi {
  final dio = Dio();

  Future<CharactersResponseDto?> getCharacters({
    required int page,
  }) async {
    try {
      final response = await dio
          .get('https://rickandmortyapi.com/api/character/?page=$page');

      final data = CharactersResponseDto.fromJson(response.data);
      return data;
    } on DioError catch (error) {
      print(error.message);
      return null;
    }
  }

  Future<CharacterEntity?> getCharacter({
  required int id,
}) async {
    try {
      final response = await dio
          .get('https://rickandmortyapi.com/api/character/$id');

      final data = CharacterEntity.fromJson(response.data);
      return data;
    } on DioError catch (error) {
      print(error.message);
      return null;
    }
  }
}
