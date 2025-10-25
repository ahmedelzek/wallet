import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LanguageCubit extends Cubit<Locale> {
  static const String _boxName = 'settings';
  static const String _langKey = 'lang';

  LanguageCubit() : super(const Locale('en')) {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final box = Hive.box(_boxName);
    final langCode = box.get(_langKey, defaultValue: 'en');
    emit(Locale(langCode));
  }

  Future<void> changeLanguage(String langCode) async {
    final box = Hive.box(_boxName);
    await box.put(_langKey, langCode);
    emit(Locale(langCode));
  }
}