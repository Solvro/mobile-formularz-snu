import "dart:async";
import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:external_app_launcher/external_app_launcher.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../constants/app_dimensions.dart";
import "../../../extensions/context_extensions.dart";
import "../../../navigation/app_router.dart";
import "../data/alarm_cache_repository.dart";

class AlarmInfo extends HookWidget {
  const AlarmInfo();

  @override
  Widget build(BuildContext context) {
    final nextAlarm =
        useFuture(Future.microtask(AlarmLocalRepository.loadAlarmSettings));

    if (nextAlarm.hasError) {
      return const SizedBox();
    }

    if (!nextAlarm.hasData) {
      return const SizedBox();
    }

    final data = nextAlarm.requireData;

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.heightMedium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                Icons.alarm,
                size: 100,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.heightMedium),
          if (data.isEnabled)
            RichText(
              text: TextSpan(
                text: "Następny alarm przypominający o ankiecie ustawiono na: ",
                style: context.theme.textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: data.time.format(context),
                    style: context.theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          if (!data.isEnabled)
            Text(
              kIsWeb || Platform.isIOS
                  ? "Pamiętaj, aby ustawić alarm w aplikacji Zegar. Zalecamy ustawienie alarmu na maksymalnie 60 minut po pobudce."
                  : "Alarm jest wyłączony. Ustaw alarm, aby otrzymywać przypomnienie.",
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: AppDimensions.heightMedium),
          if (!kIsWeb)
            OutlinedButton(
              onPressed: () {
                if (Platform.isIOS) {
                  unawaited(
                    LaunchApp.openApp(
                      iosUrlScheme: "clock:",
                      appStoreLink:
                          "itms-apps://itunes.apple.com/us/app/clock/id1584215688",
                      openStore: true,
                    ),
                  );
                } else {
                  unawaited(context.router.push(const AlarmRoute()));
                }
              },
              child: data.isEnabled
                  ? const Text("Zmień alarm")
                  : const Text("Ustaw alarm"),
            ),
        ],
      ),
    );
  }
}
