import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of MyLocalizations
/// returned by `MyLocalizations.of(context)`.
///
/// Applications need to include `MyLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MyLocalizations.localizationsDelegates,
///   supportedLocales: MyLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the MyLocalizations.supportedLocales
/// property.
abstract class MyLocalizations {
  MyLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MyLocalizations? of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static const LocalizationsDelegate<MyLocalizations> delegate =
      _MyLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// Bu onboarding title
  ///
  /// In en, this message translates to:
  /// **'Welcome to Talabajon'**
  String get welcome_talabajon;

  /// Bu languageni tanlash
  ///
  /// In en, this message translates to:
  /// **'Please select a language for the app'**
  String get please_select_language_for_app;

  /// Bu register title1
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account;

  /// Bu register title2
  ///
  /// In en, this message translates to:
  /// **'Create an account to use the app'**
  String get create_account_to_use_app;

  /// Bu textField first name
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get first_name;

  /// Bu textFiled last name
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get last_name;

  /// Bu textFiled username
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Bu textFiled password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Bu register success
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get create_profile;

  /// Bu textField referral
  ///
  /// In en, this message translates to:
  /// **'Referral Id (Optional)'**
  String get referral_id;

  /// Bu verify title
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get enter_the_code;

  /// Bu verify ogoxlantirish time
  ///
  /// In en, this message translates to:
  /// **'Go to the Telegram bot below and\nget your 5-minute code'**
  String get go_to_minute;

  /// Bu verify title2
  ///
  /// In en, this message translates to:
  /// **'Get the code'**
  String get get_the_code;

  /// Bu verify time
  ///
  /// In en, this message translates to:
  /// **'Verification code has been sent:'**
  String get verification_code_has_been_sent;

  /// Bu verify success
  ///
  /// In en, this message translates to:
  /// **'Get code'**
  String get get_code;

  /// Bu login title
  ///
  /// In en, this message translates to:
  /// **'Welcome to Talabajon!'**
  String get welcome_to_talabajon;

  /// Bu login title2
  ///
  /// In en, this message translates to:
  /// **'Log in to your account\nto use the app'**
  String get log_in_your_account_use_the_app;

  /// Bu login success
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Bu login dan registerga otish
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// Bu register login go
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get already_have_account;

  /// Bu login register go
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get dont_have_account;

  /// Bu home copy text
  ///
  /// In en, this message translates to:
  /// **'Text has been copied to clipboard ✅'**
  String get text_been_copied_clipboard;

  /// Bu home balance
  ///
  /// In en, this message translates to:
  /// **'Balance:'**
  String get balance;

  /// Bu home service
  ///
  /// In en, this message translates to:
  /// **'Popularity service'**
  String get popularity_service;

  /// Bu home taqdimot
  ///
  /// In en, this message translates to:
  /// **'Prepare a presentation'**
  String get prepare_presentation;

  /// Bu home mustaqil ish
  ///
  /// In en, this message translates to:
  /// **'Do an independent assignment'**
  String get do_independent_assignment;

  /// Bu home referat
  ///
  /// In en, this message translates to:
  /// **'Write a report'**
  String get write_report;

  /// Bu bottomBar title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Bu bottomBar title
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balanceBottom;

  /// Bu bottomBar title
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// Bu bottomBar title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Bu my account
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// Bu my account thema
  ///
  /// In en, this message translates to:
  /// **'Enable Dark Mode'**
  String get enable_dark_mode;

  /// Bu my account setting
  ///
  /// In en, this message translates to:
  /// **'Settings profile'**
  String get settings_profile;

  /// Bu my account referral
  ///
  /// In en, this message translates to:
  /// **'Referral system'**
  String get referral_system;

  /// Bu my account introduction
  ///
  /// In en, this message translates to:
  /// **'Introduction app'**
  String get introduction_app;

  /// Bu my account share
  ///
  /// In en, this message translates to:
  /// **'Share friends'**
  String get share_friends;

  /// Bu my account contact
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contact_us;

  /// Bu my account language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Bu my account about
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Bu my account log out
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// Bu my account language
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switch_language;

  /// Bu profile phone number
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// Bu profile success
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get update_profile;
}

class _MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const _MyLocalizationsDelegate();

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(lookupMyLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_MyLocalizationsDelegate old) => false;
}

MyLocalizations lookupMyLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return MyLocalizationsEn();
    case 'ru':
      return MyLocalizationsRu();
    case 'uz':
      return MyLocalizationsUz();
  }

  throw FlutterError(
    'MyLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
