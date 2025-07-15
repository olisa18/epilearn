import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeState {
  final List<EpisodeModel> episodes;
  final bool isLoading;
  final bool hasNextPage;
  final int currentPage;
  final String? error;

  EpisodeState({
    required this.episodes,
    required this.isLoading,
    required this.hasNextPage,
    required this.currentPage,
    this.error,
  });

  factory EpisodeState.initial() {
    return EpisodeState(
      episodes: [],
      isLoading: false,
      hasNextPage: true,
      currentPage: 1,
      error: null,
    );
  }

  EpisodeState copyWith({
    List<EpisodeModel>? episodes,
    bool? isLoading,
    bool? hasNextPage,
    int? currentPage,
    String? error,
  }) {
    return EpisodeState(
      episodes: episodes ?? this.episodes,
      isLoading: isLoading ?? this.isLoading,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      currentPage: currentPage ?? this.currentPage,
      error: error,
    );
  }
}
