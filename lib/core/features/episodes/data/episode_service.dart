import 'package:dio/dio.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeService {
  final Dio dio;

  EpisodeService(this.dio);

  Future<List<EpisodeModel>> fetchEpisodes({int page = 1}) async {
    final response = await dio.get('episode', queryParameters: {'page': page});

    final results = response.data['results'] as List<dynamic>;
    return results.map((json) => EpisodeModel.fromJson(json)).toList();
  }
}
