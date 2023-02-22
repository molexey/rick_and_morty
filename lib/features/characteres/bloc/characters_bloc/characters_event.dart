part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharactersEvent {
  final bool refresh;
  const LoadCharacters({this.refresh = true});
}