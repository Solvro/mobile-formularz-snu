import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Sleep Control App'**
  String get app_title;

  /// No description provided for @email_text_field_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get email_text_field_hint;

  /// No description provided for @email_error.
  ///
  /// In en, this message translates to:
  /// **'You have to pass a valid email...'**
  String get email_error;

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questions;

  /// No description provided for @questions_headline.
  ///
  /// In en, this message translates to:
  /// **'😴 Please fill in the survey 😴'**
  String get questions_headline;

  /// No description provided for @go_to_bed_time.
  ///
  /// In en, this message translates to:
  /// **'The time you went to bed last night'**
  String get go_to_bed_time;

  /// No description provided for @go_sleep_time.
  ///
  /// In en, this message translates to:
  /// **'The time you went to sleep'**
  String get go_sleep_time;

  /// No description provided for @fall_asleep_time.
  ///
  /// In en, this message translates to:
  /// **'How long did it take you to fall asleep?'**
  String get fall_asleep_time;

  /// No description provided for @awakening_times.
  ///
  /// In en, this message translates to:
  /// **'How many times did you wake up during the night?'**
  String get awakening_times;

  /// No description provided for @awakening_time_total.
  ///
  /// In en, this message translates to:
  /// **'How long did these awakenings last in total?'**
  String get awakening_time_total;

  /// No description provided for @wake_up_time.
  ///
  /// In en, this message translates to:
  /// **'What time did you wake up in the morning?'**
  String get wake_up_time;

  /// No description provided for @leave_bed_time.
  ///
  /// In en, this message translates to:
  /// **'What time did you get out of bed?'**
  String get leave_bed_time;

  /// No description provided for @sleep_rate.
  ///
  /// In en, this message translates to:
  /// **'How would you rate your sleep quality? (0-5)'**
  String get sleep_rate;

  /// No description provided for @required_field_error.
  ///
  /// In en, this message translates to:
  /// **'This field is required...'**
  String get required_field_error;

  /// No description provided for @thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thank you for filling in the survey! See You tomorrow!'**
  String get thank_you;

  /// No description provided for @final_emotes.
  ///
  /// In en, this message translates to:
  /// **'😊🎊💪🚀'**
  String get final_emotes;

  /// No description provided for @alarm_settings.
  ///
  /// In en, this message translates to:
  /// **'Alarm Settings'**
  String get alarm_settings;

  /// No description provided for @enable_alarm.
  ///
  /// In en, this message translates to:
  /// **'Enable alarm'**
  String get enable_alarm;

  /// Shows daily alarm time
  ///
  /// In en, this message translates to:
  /// **'Alarm time: {time}'**
  String alarm_time(String time);

  /// No description provided for @save_alarm.
  ///
  /// In en, this message translates to:
  /// **'Save alarm'**
  String get save_alarm;

  /// No description provided for @alarm_settings_saved.
  ///
  /// In en, this message translates to:
  /// **'Alarm settings saved!'**
  String get alarm_settings_saved;

  /// No description provided for @alarm.
  ///
  /// In en, this message translates to:
  /// **'Alarm'**
  String get alarm;

  /// No description provided for @it_is_time.
  ///
  /// In en, this message translates to:
  /// **'It\'s time to fill in the survey!'**
  String get it_is_time;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
