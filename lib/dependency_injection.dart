import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:get_it/get_it.dart";
import "package:serverpod_flutter/serverpod_flutter.dart";
import "package:sleep_app/navigation/app_router.dart";

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerLazySingleton<AppRouter>(AppRouter.new);
  getIt.registerLazySingleton<Client>(
    () => Client("https://api.formularz-snu.s.solvro.pl/")
      ..connectivityMonitor = FlutterConnectivityMonitor(),
  );
}
