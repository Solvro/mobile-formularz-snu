// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AlarmScreen]
class AlarmRoute extends PageRouteInfo<void> {
  const AlarmRoute({List<PageRouteInfo>? children})
    : super(AlarmRoute.name, initialChildren: children);

  static const String name = 'AlarmRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AlarmScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        HomeRoute.name,
        args: HomeRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomeScreen(key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [QuestionsScreen]
class QuestionsRoute extends PageRouteInfo<void> {
  const QuestionsRoute({List<PageRouteInfo>? children})
    : super(QuestionsRoute.name, initialChildren: children);

  static const String name = 'QuestionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QuestionsScreen();
    },
  );
}

/// generated route for
/// [ThankYouScreen]
class ThankYouRoute extends PageRouteInfo<void> {
  const ThankYouRoute({List<PageRouteInfo>? children})
    : super(ThankYouRoute.name, initialChildren: children);

  static const String name = 'ThankYouRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ThankYouScreen();
    },
  );
}
