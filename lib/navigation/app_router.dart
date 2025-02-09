import "package:auto_route/auto_route.dart";
import "package:sleep_app/features/home_screen/presentation/home_screen.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends RootStackRouter {
  
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
  ];

}
