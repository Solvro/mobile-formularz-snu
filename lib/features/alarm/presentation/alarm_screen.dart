import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/alarm/business/alarm_service.dart";
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class AlarmScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlarmScreenState();
}

class AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);
  bool isAlarmEnabled = false;

  Future<void> loadAlarmSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isAlarmEnabled = prefs.getBool("is_alarm_enabled") ?? false;
      int hour = prefs.getInt("alarm_hour") ?? 8;
      int minute = prefs.getInt("alarm_minutes") ?? 0;
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  Future<void> saveAlarmSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_alarm_enabled", isAlarmEnabled);
    await prefs.setInt("alarm_hour", selectedTime.hour);
    await prefs.setInt("alarm_minutes", selectedTime.minute);

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
    loadAlarmSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localize.alarm_settings)),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom: AppDimensions.paddingMedium,
            right: AppDimensions.paddingMedium),
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
          child: Icon(Icons.done, color: AppColors.dark),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.localize.enable_alarm,
                  style: TextStyle(fontSize: AppDimensions.fontSizeSmall),
                ),
                Switch(
                  value: isAlarmEnabled,
                  onChanged: (value) => setState(() => isAlarmEnabled = value),
                ),
              ],
            ),
            if (isAlarmEnabled) SizedBox(height: AppDimensions.heightSmall),
            if (isAlarmEnabled)
              GestureDetector(
                onTap: () => selectTime(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingMedium,
                      horizontal: AppDimensions.paddingBig),
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
            SizedBox(height: 4 * AppDimensions.heightHuge),
          ],
        ),
      ),
    );
  }
}
