import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/models/characters/character.dart';

part 'characters_state.freezed.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = _Initial;
  const factory CharactersState.fetching() = _Fetching;
  const factory CharactersState.fetched(List<Character> characters) = _Fetched;
  const factory CharactersState.failed(String error) = _Failed;

  // factory CharactersState.fromJson(Map<String, dynamic> json) =>
  //     _$CharactersStateFromJson(json);
}