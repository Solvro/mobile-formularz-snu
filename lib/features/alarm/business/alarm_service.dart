import "dart:async";

import "package:alarm/alarm.dart";
import "package:alarm/model/volume_settings.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:sleep_app/dependency_injection.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/alarm/presentation/alarm_screen.dart";
import "package:sleep_app/features/thank_you/presentation/thank_you_screen.dart";
import "package:sleep_app/gen/assets.gen.dart";
import "package:sleep_app/navigation/app_router.dart";

class AlarmService {
  // ignore: constant_identifier_names
  static const int ALARM_ID = 1;

  static Future<void> setDailyAlarm(
    BuildContext context,
    TimeOfDay time,
    String titleText,
    String bodyText,
    String stopText,
  ) async {
    final now = DateTime.now();
    final alarmTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final alarmSettings = AlarmSettings(
      id: ALARM_ID,
      dateTime: alarmTime.isBefore(now)
          ? alarmTime.add(const Duration(days: 1))
          : alarmTime,
      assetAudioPath: Assets.alarm,
      volumeSettings: const VolumeSettings.fixed(volume: 0.01),
      notificationSettings: NotificationSettings(
        title: titleText,
        body: bodyText,
        stopButton: stopText,
        icon: "app_icon",
      ),
    );

    // ANDROID AND IOS SET UP REQUIRED
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    Future<void> initializeNotifications() async {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings("@mipmap-xxxhdpi/ic_launcher");

      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);



      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          // Handle when user taps the notification
          debugPrint("dupa");
          stopAlarm();
          navigatorKey.currentState?.pushNamed(HomeRoute.name);
        },
      );
    }

    Future<void> showAlarmNotification() async {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'alarm_channel', // Channel ID
        'Alarm Notifications', // Channel name
        channelDescription: 'Notification when alarm rings',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true, // Makes the notification persistent
        fullScreenIntent: true,
        category: AndroidNotificationCategory.alarm,
        icon: "ic_launcher",
        // actions: <AndroidNotificationAction>[
        //   AndroidNotificationAction(
        //     "dismiss_action",
        //     'Dismiss',
        //     cancelNotification: true,
        //   ),
        // ],
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        'Alarm Ringing!', // Title
        'Tap to stop the alarm', // Body
        platformChannelSpecifics,
      );
    }

    // Future<void> showAlarmNotification() async {
    //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //       AndroidNotificationDetails(
    //     'alarm_channel', // Channel ID
    //     'Alarm Notifications', // Channel name
    //     channelDescription: 'Notification when alarm rings',
    //     importance: Importance.max,
    //     priority: Priority.high,
    //     fullScreenIntent: true, // Opens app on click
    //   );

    //   const NotificationDetails platformChannelSpecifics =
    //       NotificationDetails(android: androidPlatformChannelSpecifics);

    //   await flutterLocalNotificationsPlugin.show(
    //     0, // Notification ID
    //     'Alarm Ringing!', // Title
    //     'Tap to stop the alarm', // Body
    //     platformChannelSpecifics,
    //   );
    // }

    Alarm.ringing.listen((_) {
      debugPrint("dupa");
      showAlarmNotification();
      // navigatorKey.currentState?.push(
      //   MaterialPageRoute(builder: (context) => const ThankYouScreen()),
      // );
    });

    await Alarm.set(alarmSettings: alarmSettings);
  }

  static Future<void> stopAlarm() async {
    await Alarm.stop(ALARM_ID);
  }

  static Future<bool> isAlarmActive() async {
    return Alarm.isRinging();
  }

  
}
