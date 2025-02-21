// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get app_title => 'Apka do snu';

  @override
  String get email_text_field_hint => 'Podaj swojego maila...';

  @override
  String get email_error => 'Musisz podać prawidłowy email...';

  @override
  String get questions => 'Pytania';

  @override
  String get questions_headline => '😴 Prosze wypełnij ankietę 😴';

  @override
  String get go_to_bed_time => 'Godzina, o której położyłeś się do łóżka wczoraj wieczorem';

  @override
  String get go_sleep_time => 'Godzina, o której poszedłeś spać wczoraj wieczorem';

  @override
  String get fall_asleep_time => 'Jak długo zajęło Ci, żeby zasnąć?';

  @override
  String get awakening_times => 'Ile razy wybudzałeś się ze snu?';

  @override
  String get awakening_time_total => 'Jak długo łącznie trwały te wybudzenia w łóżku?';

  @override
  String get wake_up_time => 'O której godzinie obudziłeś się rano?';

  @override
  String get leave_bed_time => 'O której godzinie wstałeś z łóżka?';

  @override
  String get sleep_rate => 'Jak oceniasz jakość swojego snu? (0-5)';

  @override
  String get required_field_error => 'Wymagane pole..';

  @override
  String get thank_you => 'Dziękujemy za wypełnienie dzisiejszej ankiety! Do zobaczenia jutro!';

  @override
  String get final_emotes => '😊🎊💪🚀';

  @override
  String get alarm_settings => 'Ustawienia budzika';

  @override
  String get enable_alarm => 'Włącz alarm';

  @override
  String alarm_time(String time) {
    return 'Budzik: $time';
  }

  @override
  String get save_alarm => 'Zapisz budzik';

  @override
  String get alarm_settings_saved => 'Ustawienia budzika zapisane!';

  @override
  String get alarm => 'Alarm';

  @override
  String get it_is_time => 'Już czas wypełnić ankietę!';

  @override
  String get stop => 'Stop';

  @override
  String get next => 'Dalej';

  @override
  String get submit => 'Prześlij';

  @override
  String get cancel => 'Anuluj';

  @override
  String get back => 'Back';
}
