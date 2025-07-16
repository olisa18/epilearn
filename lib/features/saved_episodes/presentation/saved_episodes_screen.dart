import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/features/saved_episodes/application/saved_episode_notifier.dart';
import 'package:epilearn/features/episodes/presentation/widgets/episode_card.dart';
import 'package:epilearn/features/episodes/presentation/episode_detail_screen.dart';

class SavedEpisodesScreen extends ConsumerWidget {
  const SavedEpisodesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedEpisodes = ref.watch(savedEpisodeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
      ),
      body: savedEpisodes.isEmpty
          ? const Center(child: Text('No saved episodes yet.'))
          : ListView.builder(
              itemCount: savedEpisodes.length,
              itemBuilder: (context, index) {
                final episode = savedEpisodes[index];
                return EpisodeCard(
                  episode: episode,
                  isSaved: true,
                  onSave: () => ref
                      .read(savedEpisodeNotifierProvider.notifier)
                      .unsave(episode.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EpisodeDetailScreen(episode: episode),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
