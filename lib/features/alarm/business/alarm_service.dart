import "package:alarm/alarm.dart";
import "package:alarm/model/volume_settings.dart";
import "package:flutter/material.dart";

class AlarmService {

  static Future<void> setDailyAlarm(TimeOfDay time) async {
    final now = DateTime.now();
    final alarmTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final alarmSettings = AlarmSettings(
      id: 1,
      dateTime: alarmTime.isBefore(now) ? alarmTime.add(Duration(days: 1)) : alarmTime,
      assetAudioPath: "assets/alarm.mp3",
      volumeSettings: VolumeSettings.fixed(volume: 1.0),
      loopAudio: true,
      vibrate: true,
      notificationSettings: NotificationSettings(
        title: "Alarm",
        body: "It's time!",
        stopButton: "Stop",
        icon: "app_icon",
      ),
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }

  static Future<void> stopAlarm() async {
    await Alarm.stop(1);
  }

  static Future<bool> isAlarmActive() async {
    return await Alarm.isRinging();
  }

}
