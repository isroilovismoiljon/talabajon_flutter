// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class MyLocalizationsEn extends MyLocalizations {
  MyLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome_talabajon => 'Welcome to Talabajon';

  @override
  String get please_select_language_for_app =>
      'Please select a language for the app';

  @override
  String get create_account => 'Create account';

  @override
  String get create_account_to_use_app => 'Create an account to use the app';

  @override
  String get first_name => 'First name';

  @override
  String get last_name => 'Last name';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get create_profile => 'Create Profile';

  @override
  String get referal_id => 'Referal Id (Optional)';
}
