import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:sleep_app/navigation/app_router.dart";

void main() {
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
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("pl", "PL"),
      ],

      // TODO theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

}

