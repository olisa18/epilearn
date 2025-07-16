// lib/features/saved_episodes/application/saved_episode_notifier.dart
import 'package:epilearn/features/saved_episodes/data/shared_prefs_servide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';
import 'package:epilearn/features/saved_episodes/data/saved_episode_repository.dart';

final savedEpisodeNotifierProvider =
    StateNotifierProvider<SavedEpisodeNotifier, List<EpisodeModel>>(
  (ref) => SavedEpisodeNotifier(SavedEpisodeRepository(SharedPrefsService())),
);

class SavedEpisodeNotifier extends StateNotifier<List<EpisodeModel>> {
  final SavedEpisodeRepository _repository;

  SavedEpisodeNotifier(this._repository) : super([]) {
    loadSavedEpisodes();
  }

  Future<void> loadSavedEpisodes() async {
    state = await _repository.getSavedEpisodes();
  }

  Future<void> save(EpisodeModel episode) async {
    await _repository.save(episode);
    await loadSavedEpisodes();
  }

  Future<void> unsave(int episodeId) async {
    await _repository.unsave(episodeId);
    await loadSavedEpisodes();
  }

  bool isSaved(int episodeId) {
    return state.any((e) => e.id == episodeId);
  }
}
