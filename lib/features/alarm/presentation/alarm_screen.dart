import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/alarm/business/alarm_service.dart";
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

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
      await AlarmService.setDailyAlarm(selectedTime);
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
          backgroundColor: amethyst,
          child: Icon(Icons.done, color: dark),
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
                  style: TextStyle(fontSize: 18),
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
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: amethyst, width: 2),
                  ),
                  child: Text(
                    context.localize.alarm_time(selectedTime.format(context)),
                    style: context.theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            SizedBox(height: AppDimensions.heightHuge),
            SizedBox(height: AppDimensions.heightHuge),
            SizedBox(height: AppDimensions.heightHuge),
            SizedBox(height: AppDimensions.heightHuge),
          ],
        ),
      ),
    );
  }
}
