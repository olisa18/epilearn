import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/app/app.dart';
import 'package:epilearn/app/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  var flavor = Flavor.development;

  runApp(
    ProviderScope(
      child: EpilearnApp(flavor: flavor),
    ),
  );
}
