import 'package:epilearn/features/saved_episodes/application/saved_episode_notifier.dart';
import 'package:epilearn/shared/widgets/episode_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/features/episodes/application/episode_notifier.dart';
import 'package:epilearn/features/episodes/presentation/widgets/episode_card.dart';
import 'package:epilearn/features/episodes/presentation/episode_detail_screen.dart';

class EpisodeListScreen extends ConsumerStatefulWidget {
  const EpisodeListScreen({super.key});

  @override
  ConsumerState<EpisodeListScreen> createState() => _EpisodeListScreenState();
}

class _EpisodeListScreenState extends ConsumerState<EpisodeListScreen> {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => ref.read(episodeNotifierProvider.notifier).fetchEpisodes());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        ref.read(episodeNotifierProvider.notifier).fetchEpisodes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(episodeNotifierProvider);

    // Filter episodes by search query
    final filteredEpisodes = _searchQuery.isEmpty
        ? state.episodes
        : state.episodes
            .where((episode) =>
                episode.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Episodes',
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
              )
            ],
          ),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 6,
      ),
      body: RefreshIndicator(
        color: Colors.orangeAccent,
        backgroundColor: Colors.black,
        onRefresh: () async {
          ref.read(episodeNotifierProvider.notifier).reset();
          await ref.read(episodeNotifierProvider.notifier).fetchEpisodes();
        },
        child: Column(
          children: [
            EpisodeSearchBar(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            Expanded(
              child: state.isLoading && filteredEpisodes.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                        strokeWidth: 4,
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      itemCount:
                          filteredEpisodes.length + (state.hasNextPage ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < filteredEpisodes.length) {
                          final episode = filteredEpisodes[index];
                          final savedEpisodes =
                              ref.watch(savedEpisodeNotifierProvider);
                          final notifier =
                              ref.read(savedEpisodeNotifierProvider.notifier);
                          final isSaved =
                              savedEpisodes.any((e) => e.id == episode.id);

                          return EpisodeCard(
                            episode: episode,
                            isSaved: isSaved,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EpisodeDetailScreen(episode: episode),
                                ),
                              );
                            },
                            onSave: () {
                              if (isSaved) {
                                notifier.unsave(episode.id);
                              } else {
                                notifier.save(episode);
                              }
                            },
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.orangeAccent,
                                strokeWidth: 4,
                              ),
                            ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
