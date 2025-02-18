import "package:alarm/alarm.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:sleep_app/l10n/app_localizations.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/theme_data.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  final appRouter = AppRouter();
  runApp(MyApp(router: appRouter));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router.config(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", "US"),
        Locale("pl", "PL"),
      ],
      theme: customTheme,
    );
  }
}
