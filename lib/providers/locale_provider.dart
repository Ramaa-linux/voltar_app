import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = const Locale('id', '');

  LocaleNotifier() {
    _loadSavedLocale();
  }

  Locale get locale => _locale;

  List<Locale> get supportedLocales => const [
    Locale('id', ''),
    Locale('en', ''),
  ];

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('app_locale');
    if (saved != null) {
      _locale = Locale(saved, '');
      notifyListeners();
    }
  }

  Future<void> setLocale(String languageCode) async {
    if (_locale.languageCode == languageCode) return;
    _locale = Locale(languageCode, '');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_locale', languageCode);
    notifyListeners();
  }
}

final localeProvider = ChangeNotifierProvider<LocaleNotifier>((ref) => LocaleNotifier());