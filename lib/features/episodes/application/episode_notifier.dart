import 'package:epilearn/core/features/episodes/data/episode_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'episode_state.dart';

class EpisodeNotifier extends StateNotifier<EpisodeState> {
  final EpisodeRepository repository;

  EpisodeNotifier(this.repository) : super(EpisodeState.initial());

  Future<void> fetchEpisodes() async {
    if (state.isLoading || !state.hasNextPage) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final newEpisodes = await repository.getEpisodes(state.currentPage);
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
