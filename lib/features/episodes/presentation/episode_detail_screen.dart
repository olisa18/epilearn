import 'package:epilearn/features/episodes/application/episode_detail_notifier.dart';
import 'package:epilearn/shared/widgets/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeDetailScreen extends ConsumerWidget {
  final EpisodeModel episode;

  const EpisodeDetailScreen({super.key, required this.episode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(episodeDetailsProvider(episode));

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.orangeAccent),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black87,
        title: Text(
          episode.name,
          style: const TextStyle(
            fontFamily: 'ComicSans',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.orangeAccent,
            shadows: [
              Shadow(
                color: Colors.deepOrange,
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
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.orangeAccent,
                )),
            const SizedBox(height: 6),
            Text('Air Date: ${episode.airDate}',
                style: const TextStyle(
                  fontFamily: 'ComicSans',
                  fontSize: 18,
                  color: Colors.grey,
                )),
            const SizedBox(height: 20),
            const Text('Characters:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orangeAccent,
                    fontFamily: 'ComicSans')),
            const SizedBox(height: 12),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularLoader(
                        size: 60,
                        color: Colors.orangeAccent,
                      ),
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
                      separatorBuilder: (_, __) => const Divider(
                        color: Colors.orangeAccent,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final character = state.characters[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(character.image),
                            radius: 28,
                            backgroundColor:
                                Colors.orangeAccent.withValues(alpha: 0.3),
                          ),
                          title: Text(
                            character.name,
                            style: const TextStyle(
                              fontFamily: 'ComicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          subtitle: Text(
                            '${character.status} - ${character.species}',
                            style: const TextStyle(
                              fontFamily: 'ComicSans',
                              fontSize: 14,
                              color: Colors.grey,
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
