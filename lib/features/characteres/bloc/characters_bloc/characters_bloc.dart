import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';
import 'package:rick_and_morty/features/characteres/repository/characters_repository.dart';
import 'package:rick_and_morty/features/characteres/repository/characters_repository_remote.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final ICharactersRepository _charactersRepository;

  CharactersBloc(this._charactersRepository) : super(const CharactersState()) {
    on<LoadCharacters>(_onLoadCharacters);
  }

  Future<void> _onLoadCharacters(
      LoadCharacters event,
      Emitter<CharactersState> emit,
      ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    try {
      final result = await _charactersRepository.getCharacters(event.refresh);
      emit(state.copyWith(
        status: StatsStatus.success,
        items: result,
        isHasMorePage: _charactersRepository.hasMorePage,
      ));
    } on Exception catch (e) {
      print(e);
      emit(state.copyWith(status: StatsStatus.failure));
    }
  }
}
