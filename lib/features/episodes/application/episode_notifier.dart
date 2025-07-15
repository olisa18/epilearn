import 'package:epilearn/core/features/episodes/data/episode_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'episode_state.dart';

class EpisodeNotifier extends StateNotifier<EpisodeState> {
  final EpisodeService episodeService;

  EpisodeNotifier(this.episodeService) : super(EpisodeState.initial());

  Future<void> fetchEpisodes() async {
    if (state.isLoading || !state.hasNextPage) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final newEpisodes =
          await episodeService.fetchEpisodes(page: state.currentPage);
      final hasNext = newEpisodes.length == 20;

      state = state.copyWith(
        episodes: [...state.episodes, ...newEpisodes],
        isLoading: false,
        hasNextPage: hasNext,
        currentPage: state.currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
