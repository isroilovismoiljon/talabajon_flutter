import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit({required String locale})
      : _currentLocale = locale,
        super(Locale(locale));

  String _currentLocale;
  final prefs = SharedPreferencesAsync();

  String get currentLocale => _currentLocale;

  Future<void> changeLocale({required String locale}) async {
    await prefs.setString("locale", locale);
    _currentLocale = locale;
    emit(Locale(locale));
  }
}
