import "package:flutter/material.dart";
import "package:sleep_app/l10n/app_localizations.dart";
import "package:sleep_app/l10n/app_localizations_pl.dart";

extension BuildContextX on BuildContext {
  AppLocalizations get localize {
    return AppLocalizations.of(this) ?? AppLocalizationsPl();
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
