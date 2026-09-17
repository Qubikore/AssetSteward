import 'dart:developer' show log;

import 'package:asset_steward_app/main.export.dart';
import 'package:chirp_addons/chirp_addons.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Chirp.root = ChirpLogger()
    ..addConsoleWriter(
      output: log,
      capabilities: const TerminalCapabilities(colorSupport: .ansi256),
      formatter: ChirpPrettyJsonFormatter(getCallerInfo: kDebugMode),
    );
  await configureDependencies();

  FlutterError.onError = (details) {
    Chirp.error(details.summary, error: details.exception, stackTrace: details.stack);
    FlutterError.presentError(details);
  };

  runApp(ProviderScope(retry: (_, _) => null, child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeControllerProvider);

    return MaterialApp.router(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: themeMode,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      builder: (context, child) => ToastWrapper(child: child!),
    );
  }
}
