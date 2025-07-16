import 'package:epilearn/core/features/characters/domain/character_model.dart';
import 'package:epilearn/features/episodes/application/episode_detail_state.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class EpisodeDetailsNotifier extends StateNotifier<EpisodeDetailsState> {
  EpisodeDetailsNotifier(EpisodeModel episode)
      : super(EpisodeDetailsState(episode: episode)) {
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final dio = Dio();
      List<CharacterModel> characters = [];

      for (final url in state.episode.characterUrls) {
        final response = await dio.get(url);
        characters.add(CharacterModel.fromJson(response.data));
      }

      state = state.copyWith(characters: characters, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }
}

final episodeDetailsProvider = StateNotifierProvider.family<
    EpisodeDetailsNotifier, EpisodeDetailsState, EpisodeModel>(
  (ref, episode) => EpisodeDetailsNotifier(episode),
);
