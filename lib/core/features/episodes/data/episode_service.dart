import 'package:dio/dio.dart';
import 'package:epilearn/core/shared/providers/dio_provider.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EpisodeService {
  final Dio dio;

  EpisodeService(this.dio);

  Future<List<EpisodeModel>> fetchEpisodes({int page = 1}) async {
    final response = await dio.get('episode', queryParameters: {'page': page});

    final results = response.data['results'] as List<dynamic>;
    return results.map((json) => EpisodeModel.fromJson(json)).toList();
  }
}

final episodeServiceProvider = Provider<EpisodeService>((ref) {
  final dio = ref.watch(dioProvider);
  return EpisodeService(dio);
});
