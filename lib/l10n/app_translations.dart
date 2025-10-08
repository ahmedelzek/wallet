import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationService {
  static final LocalizationService instance = LocalizationService._();
  AppLocalizations? _localizations;

  LocalizationService._();

  void update(BuildContext context) {
    _localizations = AppLocalizations.of(context);
  }

  AppLocalizations get tr {
    if (_localizations == null) {
      throw Exception("LocalizationService not initialized. Call update(context) first.");
    }
    return _localizations!;
  }
}
