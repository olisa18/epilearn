import 'package:epilearn/features/episodes/domain/episode_model.dart';
import 'package:epilearn/features/episodes/presentation/episode_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:epilearn/features/episodes/presentation/episode_list_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _episodesTabNavigatorKey = GlobalKey<NavigatorState>();

abstract class AppRoutes {
  static const String episodes = '/episodes';
  static const String saved = '/saved';
  static const String episodeDetail = '/episodeDetail';
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.episodes,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: '${AppRoutes.episodeDetail}/:id',
        pageBuilder: (context, state) {
          final episode = state.extra;
          if (episode == null || episode is! EpisodeModel) {
            return getPage(
              child: Scaffold(
                body: Center(child: Text('Episode data not found')),
              ),
              state: state,
            );
          }

          return getPage(
            child: EpisodeDetailScreen(episode: episode),
            state: state,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: _episodesTabNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.episodes,
                pageBuilder: (context, state) => getPage(
                  child: const EpisodeListScreen(),
                  state: state,
                ),
              ),
            ],
          ),
          // StatefulShellBranch(
          //   navigatorKey: _savedTabNavigatorKey,
          //   routes: [
          //     GoRoute(
          //       path: AppRoutes.saved,
          //       pageBuilder: (context, state) => getPage(
          //         child: const SavedEpisodesScreen(),
          //         state: state,
          //       ),
          //     ),
          //   ],
          // ),
        ],
        pageBuilder: (context, state, navigationShell) => getPage(
          child: Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Episodes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'Saved',
                ),
              ],
            ),
          ),
          state: state,
        ),
      ),
    ],
  );
});

Page getPage({
  required Widget child,
  required GoRouterState state,
}) {
  return MaterialPage(
    key: state.pageKey,
    child: child,
  );
}
