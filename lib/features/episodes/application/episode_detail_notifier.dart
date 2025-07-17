import 'package:epilearn/core/features/characters/domain/character_model.dart';
import 'package:epilearn/features/episodes/application/episode_detail_state.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class EpisodeDetailParams {
  final EpisodeModel episode;
  final String name;
  final String? status;
  final String? species;

  EpisodeDetailParams({
    required this.episode,
    this.name = '',
    this.status,
    this.species,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeDetailParams &&
          runtimeType == other.runtimeType &&
          episode.id == other.episode.id &&
          name == other.name &&
          status == other.status &&
          species == other.species;

  @override
  int get hashCode =>
      episode.id.hashCode ^ name.hashCode ^ status.hashCode ^ species.hashCode;
}

class EpisodeDetailsNotifier extends StateNotifier<EpisodeDetailsState> {
  final EpisodeDetailParams params;

  List<CharacterModel> allCharacters = [];

  EpisodeDetailsNotifier(this.params)
      : super(EpisodeDetailsState(episode: params.episode)) {
    fetchAllCharacters();
  }

  Future<void> fetchAllCharacters() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final dio = Dio();
      List<CharacterModel> fetchedCharacters = [];

      for (final url in state.episode.characterUrls) {
        final response = await dio.get(url);
        final character = CharacterModel.fromJson(response.data);
        fetchedCharacters.add(character);
      }

      allCharacters = fetchedCharacters;

      final seen = <String>{};
      final fullSpeciesList = <String>[];

      for (final c in allCharacters) {
        final normalized = c.species.trim().toLowerCase();
        if (!seen.contains(normalized)) {
          seen.add(normalized);
          fullSpeciesList.add(c.species.trim());
        }
      }

      fullSpeciesList.sort();

      _applyFilters(fullSpeciesList);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  void _applyFilters(List<String> fullSpeciesList) {
    final filteredCharacters = allCharacters.where((character) {
      final matchesName =
          character.name.toLowerCase().contains(params.name.toLowerCase());
      final matchesStatus = params.status == null ||
          params.status == '' ||
          character.status.toLowerCase() == params.status?.toLowerCase();
      final matchesSpecies = params.species == null ||
          params.species == '' ||
          character.species.toLowerCase() == params.species?.toLowerCase();

      return matchesName && matchesStatus && matchesSpecies;
    }).toList();

    state = state.copyWith(
      characters: filteredCharacters,
      speciesList: fullSpeciesList,
      isLoading: false,
    );
  }
}

final episodeDetailsProvider = StateNotifierProvider.family.autoDispose<
    EpisodeDetailsNotifier, EpisodeDetailsState, EpisodeDetailParams>(
  (ref, params) => EpisodeDetailsNotifier(params),
);
