import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/alarm/business/alarm_service.dart";
import "package:sleep_app/features/alarm/data/alarm_cache_repository.dart";

import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class AlarmScreen extends HookWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTime = useState(const TimeOfDay(hour: 8, minute: 0));
    final isAlarmEnabled = useState(false);

    useEffect(
      () {
        Future.microtask(() async {
          final alarmSettings = await AlarmLocalRepository.loadAlarmSettings();
          isAlarmEnabled.value = alarmSettings.isEnabled;
          selectedTime.value = alarmSettings.time;
        });
        return null;
      },
      [],
    );

    Future<void> saveAlarmSettings() async {
      final alarmSettings = (
        isEnabled: isAlarmEnabled.value,
        time: selectedTime.value,
      );
      await AlarmLocalRepository.saveAlarmSettings(alarmSettings);

      if (isAlarmEnabled.value) {
        if (!context.mounted) return;
        await AlarmService.setDailyAlarm(context, selectedTime.value);
      } else {
        await AlarmService.stopAlarm();
      }
    }

    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime.value,
      );

      if (picked != null && picked != selectedTime.value) {
        selectedTime.value = picked;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Ustawienia alarmu")),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(
          bottom: AppDimensions.paddingMedium,
          right: AppDimensions.paddingMedium,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.heightBig),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.heightSmall / 3),
              child: Text(
                "Ustaw alarm, aby pamiętać o codziennym wypełnieniu ankiety.\nRekomendujemy godzinę poranną, najpóźniej 60 minut po przebudzeniu.  ⏰",
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize:
                      MediaQuery.of(context).size.height < 600 ? 18 : null,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: AppDimensions.heightMedium),
            Expanded(
              child: Align(
                alignment: const Alignment(0, -1 / 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingMedium,
                        horizontal: AppDimensions.paddingBig,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusMedium,
                        ),
                        border: Border.all(color: AppColors.amethyst, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.localize.enable_alarm,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontSizeSmall,
                            ),
                          ),
                          Switch(
                            activeColor: AppColors.light,
                            value: isAlarmEnabled.value,
                            onChanged: (value) => isAlarmEnabled.value = value,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.heightSmall),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: !isAlarmEnabled.value ? 0 : 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingMedium,
                          horizontal: AppDimensions.paddingBig,
                        ).copyWith(right: AppDimensions.heightSmall / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusMedium,
                          ),
                          border:
                              Border.all(color: AppColors.amethyst, width: 2),
                        ),
                        child: Row(
                          children: [
                            Text(
                              context.localize.alarm_time(
                                selectedTime.value.format(context),
                              ),
                              style: context.theme.textTheme.bodyMedium,
                            ),
                            const Spacer(),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.light,
                                iconColor: AppColors.light,
                              ),
                              onPressed: () async {
                                await selectTime(context);
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text("Edytuj"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 3),
                    ElevatedButton(
                      onPressed: () async {
                        await saveAlarmSettings();
                        if (!context.mounted) return;
                        context.router.popForced();
                      },
                      child: const Text("Zapisz alarm"),
                    ),
                    const SizedBox(height: AppDimensions.heightBig),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
