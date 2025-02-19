import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/alarm/business/alarm_service.dart";
import "package:sleep_app/features/alarm/data/alarm_cache_repository.dart";
import "package:sleep_app/features/alarm/data/alarm_settings.dart"
    show AlarmSettings;
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class AlarmScreen extends HookWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alarmCacheRepository = useMemoized(AlarmCacheRepository.new);
    final selectedTime = useState(const TimeOfDay(hour: 8, minute: 0));
    final isAlarmEnabled = useState(false);

    useEffect(
      () {
        Future.microtask(() async {
          final alarmSettings = await alarmCacheRepository.loadAlarmSettings();
          isAlarmEnabled.value = alarmSettings.isEnabled;
          selectedTime.value = alarmSettings.time;
        });
        return null;
      },
      [],
    );

    Future<void> saveAlarmSettings() async {
      final alarmSettings = AlarmSettings(
        isEnabled: isAlarmEnabled.value,
        time: selectedTime.value,
      );
      await alarmCacheRepository.saveAlarmSettings(alarmSettings);

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
      initialTime: selectedTime,
    );

      if (picked != null && picked != selectedTime.value) {
        selectedTime.value = picked;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.localize.alarm_settings)),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.paddingMedium,
          right: AppDimensions.paddingMedium,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            await saveAlarmSettings();
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.localize.alarm_settings_saved)),
            );
            context.router.popForced();
          },
          backgroundColor: AppColors.amethyst,
          child: const Icon(Icons.done, color: AppColors.dark),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.localize.enable_alarm,
                  style: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
                ),
                Switch(
                  value: isAlarmEnabled.value,
                  onChanged: (value) => isAlarmEnabled.value = value,
                ),
              ],
            ),
            if (isAlarmEnabled.value)
              const SizedBox(height: AppDimensions.heightSmall),
            if (isAlarmEnabled.value)
              GestureDetector(
                onTap: () async => selectTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingMedium,
                    horizontal: AppDimensions.paddingBig,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadiusMedium),
                    border: Border.all(color: AppColors.amethyst, width: 2),
                  ),
                  child: Text(
                    context.localize
                        .alarm_time(selectedTime.value.format(context)),
                    style: context.theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            const SizedBox(height: 4 * AppDimensions.heightHuge),
          ],
        ),
      ),
    );
  }
}
