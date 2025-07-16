import 'package:epilearn/features/saved_episodes/application/saved_episode_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/features/episodes/application/episode_notifier.dart';
import 'package:epilearn/features/episodes/presentation/widgets/episode_card.dart';
import 'package:epilearn/features/episodes/presentation/episode_detail_screen.dart'; // import detail screen

class EpisodeListScreen extends ConsumerStatefulWidget {
  const EpisodeListScreen({super.key});

  @override
  ConsumerState<EpisodeListScreen> createState() => _EpisodeListScreenState();
}

class _EpisodeListScreenState extends ConsumerState<EpisodeListScreen> {
  final ScrollController _scrollController = ScrollController();

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

    return Scaffold(
      appBar: AppBar(title: const Text('Episodes')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(episodeNotifierProvider.notifier).reset();
          await ref.read(episodeNotifierProvider.notifier).fetchEpisodes();
        },
        child: state.isLoading && state.episodes.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: state.episodes.length + (state.hasNextPage ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.episodes.length) {
                    final episode = state.episodes[index];
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
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
