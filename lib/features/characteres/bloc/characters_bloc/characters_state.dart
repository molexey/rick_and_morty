part of 'characters_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

class CharactersState extends Equatable {
  final StatsStatus status;
  final List<CharacterEntity> items;
  final bool isHasMorePage;

  const CharactersState({
    this.status = StatsStatus.initial,
    this.items = const <CharacterEntity>[],
    this.isHasMorePage = false,
  });

  @override
  List<Object> get props => [status, items, isHasMorePage];

  CharactersState copyWith({
    StatsStatus? status,
    List<CharacterEntity>? items,
    bool? isHasMorePage,
  }) {
    return CharactersState(
      status: status ?? this.status,
      items: items ?? this.items,
      isHasMorePage: isHasMorePage ?? this.isHasMorePage,
    );
  }
}