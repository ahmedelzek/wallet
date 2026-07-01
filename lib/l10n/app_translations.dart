import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationService {
  static final LocalizationService instance = LocalizationService._();
  LocalizationService._();

  AppLocalizations tr(BuildContext context) {
    final tr = AppLocalizations.of(context);
    if (tr == null) {
      throw Exception("AppLocalizations not found. Make sure localizationsDelegates are set.");
    }
    return tr;
  }
}