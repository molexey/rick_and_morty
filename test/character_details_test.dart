import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/features/character_details/bloc/character_details_bloc/character_details_bloc.dart';
import 'package:rick_and_morty/features/character_details/repository/character_repository.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';
import 'package:rick_and_morty/features/characteres/entity/character_location_entity.dart';

final mockCharacter = CharacterEntity(
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
);

class MockICharacterRepository extends Mock implements ICharacterRepository {}

void main() {
  group('Characters', () {
    late CharacterDetailsBloc characterDetailsBloc;
    late ICharacterRepository characterRepository;

    setUp(() {
      characterRepository = MockICharacterRepository();
      characterDetailsBloc = CharacterDetailsBloc(characterRepository);
    });

    test(
      'Начальное состояние блока CharacterDetailsBloc loading',
      () => expect(
        characterDetailsBloc.state,
        const CharacterDetailsState(status: CharacterStatus.loading),
      ),
    );

    blocTest<CharacterDetailsBloc, CharacterDetailsState>(
      'Смена состояний [CharacterStatus.loading, CharacterStatus.success] при успешной загрузке данных',
      build: () {
        when(() => characterRepository.getCharacter(1))
            .thenAnswer((invocation) => Future.value(mockCharacter));
        return CharacterDetailsBloc(characterRepository);
      },
      act: (bloc) => bloc.add(const LoadCharacter(1)),
      expect: () => <CharacterDetailsState>[
        const CharacterDetailsState(status: CharacterStatus.loading),
        CharacterDetailsState(
            status: CharacterStatus.success, item: mockCharacter),
      ],
    );

    tearDown(() {
      characterDetailsBloc.close();
    });
  });
}
