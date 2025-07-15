class EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characterUrls;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characterUrls,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
      characterUrls: List<String>.from(json['characters']),
    );
  }
}
