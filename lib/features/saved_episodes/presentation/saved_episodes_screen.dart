import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:epilearn/features/saved_episodes/application/saved_episode_notifier.dart';
import 'package:epilearn/features/episodes/presentation/widgets/episode_card.dart';
import 'package:epilearn/features/episodes/presentation/episode_detail_screen.dart';
import 'package:epilearn/shared/widgets/episode_search_bar.dart';

class SavedEpisodesScreen extends ConsumerStatefulWidget {
  const SavedEpisodesScreen({super.key});

  @override
  ConsumerState<SavedEpisodesScreen> createState() =>
      _SavedEpisodesScreenState();
}

class _SavedEpisodesScreenState extends ConsumerState<SavedEpisodesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final savedEpisodes = ref.watch(savedEpisodeNotifierProvider);

    final filteredEpisodes = _searchQuery.isEmpty
        ? savedEpisodes
        : savedEpisodes
            .where((episode) =>
                episode.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF12182C),
      appBar: AppBar(
        title: const Text(
          'Saved Episodes',
          style: TextStyle(
            fontFamily: 'ComicSans',
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Color(0xFF00FFF7),
            letterSpacing: 1.2,
            height: 1.2,
          ),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 8,
      ),
      body: Column(
        children: [
          EpisodeSearchBar(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          Expanded(
            child: filteredEpisodes.isEmpty
                ? Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? 'No saved episodes yet.'
                          : 'No saved episodes found.',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: 'ComicSans',
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    itemCount: filteredEpisodes.length,
                    itemBuilder: (context, index) {
                      final episode = filteredEpisodes[index];
                      final notifier =
                          ref.read(savedEpisodeNotifierProvider.notifier);

                      return EpisodeCard(
                        episode: episode,
                        isSaved: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EpisodeDetailScreen(episode: episode),
                            ),
                          );
                        },
                        onSave: () {
                          notifier.unsave(episode.id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
