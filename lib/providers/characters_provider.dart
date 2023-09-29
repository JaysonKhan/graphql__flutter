import 'package:graphql_flutter/models/characters/character.dart';
import 'package:graphql_flutter/providers/characters_state.dart';
import 'package:riverpod/riverpod.dart';
import 'package:dio/dio.dart';

final charactersProvider =
    StateNotifierProvider<CharactersProvider, CharactersState>((ref) =>
        CharactersProvider(const CharactersState.initial())..fetchCharacters());

class CharactersProvider extends StateNotifier<CharactersState> {
  CharactersProvider(super.state);

  fetchCharacters() async {
    state = const CharactersState.fetching();
    try {
      Dio dio = Dio(BaseOptions(baseUrl: "https://rickandmortyapi.com"));
      final response = await dio.post("/graphql", data: {
        'query': r'''
                query {
                  characters{
                    results{
                      id
                      name
                      image
                      status
                    }
                 }
                }
        '''
      });
      List<dynamic> responceData =
          response.data['data']['characters']['results'];
      state = CharactersState.fetched(
          responceData.map((e) => Character.fromJson(e)).toList());
    } on DioException catch (e) {
      state = CharactersState.failed(e.message!);
    } catch (e) {
      state = const CharactersState.failed("Failed to get GraphQL elements");
    }
  }
}
