import 'package:epilearn/features/episodes/domain/episode_model.dart';
import 'package:epilearn/features/episodes/presentation/episode_detail_screen.dart';
import 'package:epilearn/features/saved_episodes/presentation/saved_episodes_screen.dart';
import 'package:epilearn/home_screen.dart';
import 'package:epilearn/shared/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:epilearn/features/episodes/presentation/episode_list_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _episodesTabNavigatorKey = GlobalKey<NavigatorState>();
final _savedTabNavigatorKey = GlobalKey<NavigatorState>();

abstract class AppRoutes {
  static const String home = '/';
  static const String episodes = '/episodes';
  static const String saved = '/saved';
  static const String episodeDetail = '/episodeDetail';
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => getPage(
          child: const HomeScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: '${AppRoutes.episodeDetail}/:id',
        pageBuilder: (context, state) {
          final episode = state.extra;
          if (episode == null || episode is! EpisodeModel) {
            return getPage(
              child: const Scaffold(
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
          StatefulShellBranch(
            navigatorKey: _savedTabNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.saved,
                pageBuilder: (context, state) => getPage(
                  child: const SavedEpisodesScreen(),
                  state: state,
                ),
              ),
            ],
          ),
        ],
        pageBuilder: (context, state, navigationShell) => getPage(
          child: Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavBar(
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
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
