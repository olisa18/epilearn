import 'package:epilearn/core/features/characters/domain/character_model.dart';
import 'package:epilearn/features/episodes/application/episode_detail_notifier.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeDetailsState {
  final EpisodeModel episode;
  final List<CharacterModel> characters;
  final bool isLoading;
  final String? errorMessage;

  EpisodeDetailsState({
    required this.episode,
    this.characters = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  EpisodeDetailsState copyWith({
    List<CharacterModel>? characters,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EpisodeDetailsState(
      episode: episode,
      characters: characters ?? this.characters,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
