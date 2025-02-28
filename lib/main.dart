import "package:alarm/alarm.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:sleep_app/dependency_injection.dart";
import "package:sleep_app/l10n/app_localizations.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/theme_data.dart";

Future<void> main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  setupDependencyInjection();
  await Alarm.init();

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<AppRouter>().config(),
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
      locale: const Locale("pl", ""),
      theme: customTheme,
    );
  }
}
