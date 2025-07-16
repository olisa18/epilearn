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
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Saved Episodes',
          style: TextStyle(
            fontFamily: 'ComicSans',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.orangeAccent,
            shadows: [
              Shadow(
                color: Colors.orange,
                blurRadius: 8,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 6,
      ),
      body: savedEpisodes.isEmpty
          ? Center(
              child: Text(
                'No saved episodes yet.',
                style: TextStyle(
                  color: Colors.orangeAccent.withOpacity(0.7),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'ComicSans',
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              itemCount: savedEpisodes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
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
