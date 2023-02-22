import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/features/character_details/repository/character_repository.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';

part 'character_details_event.dart';
part 'character_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final _characterRepository = CharacterResository();

  CharacterDetailsBloc() : super(const CharacterDetailsState()) {
    on<LoadCharacter>(_onLoadCharacter);
  }

  Future<void> _onLoadCharacter(
      LoadCharacter event,
      Emitter<CharacterDetailsState> emit,
      ) async {
    emit(state.copyWith(status: CharacterStatus.loading));
    try {
      final result = await _characterRepository.getCharacter(event.id);
      emit(state.copyWith(
        status: CharacterStatus.success,
        item: result,
      ));
    } on Exception catch (e) {
      print(e);
      emit(state.copyWith(status: CharacterStatus.failure));
    }
  }
}
