import "package:alarm/alarm.dart";
import "package:alarm/model/volume_settings.dart";
import "package:flutter/material.dart";
import "package:sleep_app/extensions/context_extensions.dart";

class AlarmService {
  // ignore: constant_identifier_names
  static const int ALARM_ID = 1;

  static Future<void> setDailyAlarm(
      BuildContext context, TimeOfDay time) async {
    final now = DateTime.now();
    final alarmTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final alarmSettings = AlarmSettings(
      id: ALARM_ID,
      dateTime: alarmTime.isBefore(now)
          ? alarmTime.add(Duration(days: 1))
          : alarmTime,
      assetAudioPath: "assets/alarm.mp3",
      volumeSettings: VolumeSettings.fixed(volume: 1.0),
      loopAudio: true,
      vibrate: true,
      notificationSettings: NotificationSettings(
        title: context.localize.alarm,
        body: context.localize.it_is_time,
        stopButton: context.localize.stop,
        icon: "app_icon",
      ),
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }

  static Future<void> stopAlarm() async {
    await Alarm.stop(ALARM_ID);
  }

  static Future<bool> isAlarmActive() async {
    return await Alarm.isRinging();
  }
}
