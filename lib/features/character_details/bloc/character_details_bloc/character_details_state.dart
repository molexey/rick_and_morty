part of 'character_details_bloc.dart';

enum CharacterStatus { loading, success, failure }

class CharacterDetailsState extends Equatable {
  final CharacterStatus status;
  final CharacterEntity? item;

  const CharacterDetailsState({
    this.status = CharacterStatus.loading,
    this.item,
  });

  @override
  List<Object?> get props => [status, item];

  CharacterDetailsState copyWith({
    CharacterStatus? status,
    CharacterEntity? item,
  }) {
    return CharacterDetailsState(
      status: status ?? this.status,
      item: item ?? this.item,
    );
  }
}
