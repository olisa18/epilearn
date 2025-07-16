// lib/features/saved_episodes/data/saved_episode_repository.dart
import 'package:epilearn/features/episodes/domain/episode_model.dart';
import 'package:epilearn/features/saved_episodes/data/shared_prefs_servide.dart';

class SavedEpisodeRepository {
  final SharedPrefsService _prefsService;

  SavedEpisodeRepository(this._prefsService);

  Future<List<EpisodeModel>> getSavedEpisodes() {
    return _prefsService.loadSavedEpisodes();
  }

  Future<void> save(EpisodeModel episode) {
    return _prefsService.saveEpisode(episode);
  }

  Future<void> unsave(int episodeId) {
    return _prefsService.unsaveEpisode(episodeId);
  }
}
