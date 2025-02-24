import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/features/alarm/presentation/alarm_screen.dart";
import "package:sleep_app/features/form/presentation/form_screen.dart";
import "package:sleep_app/features/questions/presentation/questions_screen.dart";
import "package:sleep_app/features/thank_you/presentation/thank_you_screen.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: FormRoute.page, initial: true),
        AutoRoute(page: QuestionsRoute.page),
        AutoRoute(page: ThankYouRoute.page),
        AutoRoute(page: AlarmRoute.page),
      ];
}
