import 'package:epilearn/core/features/characters/domain/character_model.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeDetailsState {
  final EpisodeModel episode;
  final List<CharacterModel> characters;
  final List<String> speciesList;
  final bool isLoading;
  final String? errorMessage;

  EpisodeDetailsState({
    required this.episode,
    this.characters = const [],
    this.speciesList = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  EpisodeDetailsState copyWith({
    List<CharacterModel>? characters,
    List<String>? speciesList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EpisodeDetailsState(
      episode: episode,
      characters: characters ?? this.characters,
      speciesList: speciesList ?? this.speciesList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
