import 'package:epilearn/features/episodes/application/episode_detail_notifier.dart';
import 'package:epilearn/features/episodes/application/episode_notifier.dart';
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
      appBar: AppBar(
        title: Text(episode.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Episode Code: ${episode.episode}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Air Date: ${episode.airDate}',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 16),
            const Text('Characters:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.errorMessage != null) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  } else if (state.characters.isEmpty) {
                    return const Center(child: Text('No characters found.'));
                  } else {
                    return ListView.separated(
                      itemCount: state.characters.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final character = state.characters[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(character.image),
                          ),
                          title: Text(character.name),
                          subtitle: Text(
                              '${character.status} - ${character.species}'),
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
