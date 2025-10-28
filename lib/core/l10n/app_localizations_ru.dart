// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class MyLocalizationsRu extends MyLocalizations {
  MyLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcome_talabajon => 'Добро пожаловать в Talabajon';

  @override
  String get please_select_language_for_app =>
      'Пожалуйста, выберите язык для приложения';

  @override
  String get create_account => 'Создать аккаунт';

  @override
  String get create_account_to_use_app =>
      'Создайте аккаунт, чтобы использовать приложение';

  @override
  String get first_name => 'Имя';

  @override
  String get last_name => 'Фамилия';

  @override
  String get username => 'Имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get create_profile => 'Создать профиль';

  @override
  String get referal_id => 'Реферальный ID (Необязательно)';
}
