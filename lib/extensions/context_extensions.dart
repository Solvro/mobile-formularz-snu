import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

extension LocalizationExtension on BuildContext {
  AppLocalizations get localize => AppLocalizations.of(this)!;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}