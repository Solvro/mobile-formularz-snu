import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/alarm/data/alarm_cache_repository.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

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
        children: [
          Text(
            "Następny alarm przypominający o ankiecie ustawiono na: ${data.time.format(context)}",
            style: context.theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              unawaited(context.router.push(const AlarmRoute()));
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.lavenda,
            ),
            child: const Text("Zmień alarm"),
          ),
        ],
      ),
    );
  }
}
