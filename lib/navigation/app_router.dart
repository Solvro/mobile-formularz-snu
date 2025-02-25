import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../features/alarm/presentation/alarm_screen.dart";
import "../features/email/presentation/email_screen.dart";
import "../features/form/presentation/first_form_screen.dart";
import "../features/home/home_screen.dart";
import "../features/questions/presentation/questions_screen.dart";
import "../features/thank_you/presentation/thank_you_screen.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: EmailRoute.page),
        AutoRoute(page: QuestionsRoute.page),
        AutoRoute(page: ThankYouRoute.page),
        AutoRoute(page: AlarmRoute.page),
        AutoRoute(page: FirstFormRoute.page),
      ];
}
