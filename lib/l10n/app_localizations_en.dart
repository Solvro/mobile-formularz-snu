// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Sleep Control App';

  @override
  String get email_text_field_hint => 'Enter your email...';

  @override
  String get email_error => 'You have to pass a valid email...';

  @override
  String get questions => 'Questions';

  @override
  String get questions_headline => '😴 Please fill in the survey 😴';

  @override
  String get go_to_bed_time => 'The time you went to bed last night';

  @override
  String get go_sleep_time => 'The time you went to sleep';

  @override
  String get fall_asleep_time => 'How long did it take you to fall asleep?';

  @override
  String get awakening_times =>
      'How many times did you wake up during the night?';

  @override
  String get awakening_time_total =>
      'How long did these awakenings last in total?';

  @override
  String get wake_up_time => 'What time did you wake up in the morning?';

  @override
  String get leave_bed_time => 'What time did you get out of bed?';

  @override
  String get sleep_rate => 'How would you rate your sleep quality? (0-5)';

  @override
  String get required_field_error => 'This field is required...';

  @override
  String get thank_you =>
      'Thank you for filling in the survey! See You tomorrow!';

  @override
  String get final_emotes => '😊🎊💪🚀';

  @override
  String get alarm_settings => 'Alarm Settings';

  @override
  String get enable_alarm => 'Enable alarm';

  @override
  String alarm_time(String time) {
    return 'Alarm time: $time';
  }

  @override
  String get save_alarm => 'Save alarm';

  @override
  String get alarm_settings_saved => 'Alarm settings saved!';

  @override
  String get alarm => 'Alarm';

  @override
  String get it_is_time => 'It\'s time to fill in the survey!';

  @override
  String get stop => 'Stop';

  @override
  String get next => 'Next';

  @override
  String get submit => 'Submit';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';
}
