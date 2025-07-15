import 'package:epilearn/core/features/episodes/data/episode_service.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeRepository {
  final EpisodeService episodeService;

  EpisodeRepository(this.episodeService);

  Future<List<EpisodeModel>> getEpisodes(int page) {
    return episodeService.fetchEpisodes(page: page);
  }
}
