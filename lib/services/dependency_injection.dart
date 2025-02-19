import "package:get_it/get_it.dart";
import "package:sleep_app/navigation/app_router.dart";

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerLazySingleton<AppRouter>(AppRouter.new);
}
