import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/features/character_details/repository/character_repository.dart';
import 'package:rick_and_morty/features/characteres/bloc/characters_bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';
import 'package:rick_and_morty/features/characteres/entity/character_location_entity.dart';
import 'package:rick_and_morty/features/characteres/repository/characters_repository.dart';

final mockCharacters = [
CharacterEntity(
id: 1,
name: 'Rick Sanchez',
gender: 'Male',
image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
status: 'alive',
location: const CharacterLocationEntity(
name: 'Citadel of Ricks',
url: 'https://rickandmortyapi.com/api/location/3'),
episode: [
'https://rickandmortyapi.com/api/episode/1',
'https://rickandmortyapi.com/api/episode/2',
'https://rickandmortyapi.com/api/episode/3'
],
species: '',
type: '',
origin: const CharacterLocationEntity(
name: 'Citadel of Ricks',
url: 'https://rickandmortyapi.com/api/location/3'),
url: '',
created: DateTime.now(),
),
];

class MockICharactersRepository extends Mock implements ICharactersRepository {}

void main() {
  group('Characters', () {
    late CharactersBloc charactersBloc;
    late ICharactersRepository charactersRepository;

    setUp(() {
      charactersRepository = MockICharactersRepository();
      charactersBloc = CharactersBloc(charactersRepository);
    });

    test(
      'Начальное состояние блока CharactersBloc loading',
          () => expect(
        charactersBloc.state,
        const CharactersState(status: StatsStatus.initial, items: [], isHasMorePage: false),
      ),
    );

    blocTest<CharactersBloc, CharactersState>(
      'Смена состояний [CharactersStatus.loading, CharactersStatus.success] при успешной загрузке данных',
      build: () {
        when(() => charactersRepository.getCharacters(true))
            .thenAnswer((invocation) => Future.value(mockCharacters));
        when(() => charactersRepository.hasMorePage)
            .thenAnswer((invocation) => true);
        return CharactersBloc(charactersRepository);
      },
      act: (bloc) => bloc.add(const LoadCharacters(refresh: true) ),
      expect: () => <CharactersState>[
        const CharactersState(status: StatsStatus.loading, items: [], isHasMorePage: false),
        CharactersState(
            status: StatsStatus.success, items: mockCharacters, isHasMorePage: true),
      ],
    );

    tearDown(() {
      charactersBloc.close();
    });
  });
}