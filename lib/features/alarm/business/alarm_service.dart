import "package:alarm/alarm.dart";
import "package:alarm/model/volume_settings.dart";
import "package:flutter/material.dart";
import "package:logger/web.dart";
import "package:permission_handler/permission_handler.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/gen/assets.gen.dart";

class AlarmService {
  static Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    Logger().i("Schedule exact alarm permission: $status.");
    if (status.isDenied) {
      Logger().i("Requesting schedule exact alarm permission...");
      final res = await Permission.scheduleExactAlarm.request();
      Logger().i(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  // ignore: constant_identifier_names
  static const int ALARM_ID = 1;

  static Future<void> setDailyAlarm(
    BuildContext context,
    TimeOfDay time,
  ) async {
    final now = DateTime.now();
    final alarmTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final loc = context.localize;
    await checkAndroidScheduleExactAlarmPermission();
    final alarmSettings = AlarmSettings(
      id: ALARM_ID,
      dateTime: alarmTime.isBefore(now)
          ? alarmTime.add(const Duration(days: 1))
          : alarmTime,
      assetAudioPath: Assets.alarm,
      volumeSettings: const VolumeSettings.fixed(volume: 1),
      notificationSettings: NotificationSettings(
        title: loc.alarm,
        body: loc.it_is_time,
        stopButton: loc.stop,
        icon: "app_icon",
      ),
    );
    await Alarm.setWarningNotificationOnKill(
      "Wyłączono alarm",
      "Niestety aplikacja została zamknięta, więc alarm nie będzie mógł zadzwonić. Włącz ponownie aplikację, lub ustaw alarm w domyślnym budziku.",
    );

    await Alarm.set(alarmSettings: alarmSettings);
  }

  static Future<void> stopAlarm() async {
    await Alarm.stop(ALARM_ID);
  }

  static Future<bool> isAlarmActive() async {
    return Alarm.isRinging();
  }
}
