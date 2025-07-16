import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/core/navigation/routes.dart';
import 'env.dart';

class EpilearnApp extends ConsumerWidget {
  final Flavor flavor;

  const EpilearnApp({super.key, required this.flavor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Epilearn',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
