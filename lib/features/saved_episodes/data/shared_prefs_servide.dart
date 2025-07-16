import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:epilearn/features/episodes/domain/episode_model.dart';

class SharedPrefsService {
  static const _key = 'saved_episodes';

  Future<List<EpisodeModel>> loadSavedEpisodes() async {
    final prefs = await SharedPreferences.getInstance();
    final savedJsonList = prefs.getStringList(_key) ?? [];

    return savedJsonList
        .map((jsonStr) => EpisodeModel.fromJson(json.decode(jsonStr)))
        .toList();
  }

  Future<void> saveEpisode(EpisodeModel episode) async {
    final prefs = await SharedPreferences.getInstance();
    final savedJsonList = prefs.getStringList(_key) ?? [];

    final alreadySaved = savedJsonList.any((jsonStr) {
      final ep = EpisodeModel.fromJson(json.decode(jsonStr));
      return ep.id == episode.id;
    });

    if (!alreadySaved) {
      savedJsonList.add(json.encode(episode.toJson()));
      await prefs.setStringList(_key, savedJsonList);
    }
  }

  Future<void> unsaveEpisode(int episodeId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedJsonList = prefs.getStringList(_key) ?? [];

    final updatedList = savedJsonList.where((jsonStr) {
      final ep = EpisodeModel.fromJson(json.decode(jsonStr));
      return ep.id != episodeId;
    }).toList();

    await prefs.setStringList(_key, updatedList);
  }
}
