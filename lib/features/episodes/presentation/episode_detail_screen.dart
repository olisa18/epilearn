import 'package:epilearn/features/episodes/application/episode_detail_notifier.dart';
import 'package:epilearn/shared/widgets/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeDetailScreen extends ConsumerWidget {
  final EpisodeModel episode;

  const EpisodeDetailScreen({super.key, required this.episode});

  static const _accent = Color(0xFF00FF9F);
  static const _bg = Color(0xFF12182C);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(episodeDetailsProvider(episode));

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: _accent),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black87,
        title: Text(
          episode.name,
          style: const TextStyle(
            fontFamily: 'ComicSans',
            fontWeight: FontWeight.w900,
            fontSize: 26,
            color: _accent,
            letterSpacing: 1.1,
            shadows: [
              Shadow(
                color: Color(0xFF00BBAE),
                blurRadius: 6,
                offset: Offset(1, 1),
              )
            ],
          ),
        ),
        centerTitle: true,
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Episode Code: ${episode.episode}',
                style: const TextStyle(
                  fontFamily: 'ComicSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: _accent,
                )),
            const SizedBox(height: 6),
            Text('Air Date: ${episode.airDate}',
                style: TextStyle(
                  fontFamily: 'ComicSans',
                  fontSize: 18,
                  color: Colors.grey.shade400,
                )),
            const SizedBox(height: 20),
            const Text('Characters:',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: _accent,
                  fontFamily: 'ComicSans',
                )),
            const SizedBox(height: 12),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularLoader(size: 60, color: _accent),
                    );
                  } else if (state.errorMessage != null) {
                    return Center(
                        child: Text(
                      'Error: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.redAccent),
                    ));
                  } else if (state.characters.isEmpty) {
                    return const Center(
                      child: Text(
                        'No characters found.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: state.characters.length,
                      separatorBuilder: (_, __) => Divider(
                        color: _accent.withValues(alpha: 0.4),
                        thickness: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final character = state.characters[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white10.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(character.image),
                              radius: 28,
                              backgroundColor: _accent.withValues(alpha: 0.2),
                            ),
                            title: Text(
                              character.name,
                              style: const TextStyle(
                                fontFamily: 'ComicSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: _accent,
                              ),
                            ),
                            subtitle: Text(
                              '${character.status} - ${character.species}',
                              style: TextStyle(
                                fontFamily: 'ComicSans',
                                fontSize: 14,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
