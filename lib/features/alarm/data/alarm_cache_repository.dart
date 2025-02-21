import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sleep_app/features/alarm/data/alarm_settings.dart"
    show AlarmSettings;

class AlarmCacheRepository {
  static const String alarmEnabledKey = "is_alarm_enabled";
  static const String alarmHourKey = "alarm_hour";
  static const String alarmMinutesKey = "alarm_minutes";

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<AlarmSettings> loadAlarmSettings() async {
    final prefs = await _prefs;
    return AlarmSettings(
      isEnabled: prefs.getBool(alarmEnabledKey) ?? false,
      time: TimeOfDay(
        hour: prefs.getInt(alarmHourKey) ?? 8,
        minute: prefs.getInt(alarmMinutesKey) ?? 0,
      ),
    );
  }

  Future<void> saveAlarmSettings(AlarmSettings alarmSettings) async {
    final prefs = await _prefs;
    await prefs.setBool(alarmEnabledKey, alarmSettings.isEnabled);
    await prefs.setInt(alarmHourKey, alarmSettings.time.hour);
    await prefs.setInt(alarmMinutesKey, alarmSettings.time.minute);
  }
}
