import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/alarm/business/alarm_service.dart";
import "package:sleep_app/features/alarm/data/alarm_cache_repository.dart";
import "package:sleep_app/features/alarm/data/alarm_settings.dart"
    show AlarmSettings;
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<StatefulWidget> createState() => AlarmScreenState();
}

class AlarmScreenState extends State<AlarmScreen> {
  final alarmCacheRepository = AlarmCacheRepository();
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);
  bool isAlarmEnabled = false;

  Future<void> loadAlarmSettings() async {
    final alarmSettings = await alarmCacheRepository.loadAlarmSettings();

    setState(() {
      isAlarmEnabled = alarmSettings.isEnabled;
      selectedTime = alarmSettings.time;
    });
  }

  Future<void> saveAlarmSettings() async {
    final alarmSettings =
        AlarmSettings(isEnabled: isAlarmEnabled, time: selectedTime);
    await alarmCacheRepository.saveAlarmSettings(alarmSettings);

    if (isAlarmEnabled) {
      if (!mounted) return;
      await AlarmService.setDailyAlarm(context, selectedTime);
    } else {
      await AlarmService.stopAlarm();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker( 
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => loadAlarmSettings());
  }

  @override
  Widget build(BuildContext context) {
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
                  value: isAlarmEnabled,
                  onChanged: (value) => setState(() => isAlarmEnabled = value),
                ),
              ],
            ),
            if (isAlarmEnabled)
              const SizedBox(height: AppDimensions.heightSmall),
            if (isAlarmEnabled)
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
                    context.localize.alarm_time(selectedTime.format(context)),
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
