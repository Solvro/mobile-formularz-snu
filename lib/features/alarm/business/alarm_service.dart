import "dart:async";

import "package:alarm/alarm.dart";
import "package:alarm/model/volume_settings.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:logger/web.dart";
import "package:permission_handler/permission_handler.dart";

import "../../../gen/assets.gen.dart";

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

  static Future<void> checkLocalNotificationPermission() async {
    final status = await Permission.notification.status;
    Logger().i("Local notification permission: $status.");
    if (status.isDenied) {
      Logger().i("Requesting local notification permission...");
      final res = await Permission.notification.request();
      Logger().i(
        'Local notification permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  static Future<void> showAlarmNotification() async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "alarm_channel",
        "Alarm Notifications",
        channelDescription: "Notification when alarm rings",
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        fullScreenIntent: true,
        category: AndroidNotificationCategory.alarm,
        icon: "ic_launcher",
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
        interruptionLevel: InterruptionLevel.critical,
        presentBanner: true,
        presentList: true,
      ),
    );

    await FlutterLocalNotificationsPlugin().show(
      0,
      "Dziennik snu!",
      "Czas wypełnić formularz o twoim dzisiejszym śnie.",
      platformChannelSpecifics,
    );
  }

  // ignore: constant_identifier_names
  static const int ALARM_ID = 1;

  static Future<void> setDailyAlarm(
    TimeOfDay time,
    String titleText,
    String bodyText,
    String stopText,
  ) async {
    final now = DateTime.now();
    final alarmTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    await checkAndroidScheduleExactAlarmPermission();
    final alarmSettings = AlarmSettings(
      id: ALARM_ID,
      dateTime: alarmTime.isBefore(now)
          ? alarmTime.add(const Duration(days: 1))
          : alarmTime,
      assetAudioPath: Assets.alarm,
      volumeSettings: const VolumeSettings.fixed(volume: 0.5),
      notificationSettings: NotificationSettings(
        title: titleText,
        body: bodyText,
        stopButton: stopText,
        icon: "app_icon",
      ),
    );

    await checkLocalNotificationPermission();

    await Alarm.setWarningNotificationOnKill(
      "Wyłączono alarm",
      "Niestety aplikacja została zamknięta, więc alarm nie będzie mógł zadzwonić. Włącz ponownie aplikację, lub ustaw alarm w domyślnym budziku.",
    );

    await Alarm.set(alarmSettings: alarmSettings);
  }

  static Future<void> stopAlarm() async {
    await Alarm.stop(ALARM_ID);
  }
}
