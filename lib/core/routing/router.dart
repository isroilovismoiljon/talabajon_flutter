import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/features/auth/pages/login_page.dart';
import 'package:talabajon/features/auth/pages/register_page.dart';
import 'package:talabajon/features/auth/pages/verify_page.dart';
import 'package:talabajon/features/balance/pages/balance_page.dart';
import 'package:talabajon/features/home/pages/home_page.dart';
import 'package:talabajon/features/profile/pages/profile_page.dart';
import 'package:talabajon/features/service/pages/create_presentation_pages.dart';
import 'package:talabajon/features/setting/pages/introduction_app_page.dart';

import '../../features/presentation/pages/presentation_page.dart';
import '../../features/setting/pages/setting_page.dart';
import '../../features/splash/pages/select_lang_page.dart';
import '../../features/splash/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: Routes.splash,

  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: Routes.createPresentation,
      builder: (context, state) => CreatePresentationPage(),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => SettingPage(),
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: Routes.introductionApp,
      builder: (context, state) => IntroductionAppPage(),
    ),
    GoRoute(
      path: Routes.selectLanguage,
      builder: (context, state) => SelectLanguagePage(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: Routes.presentation,
      builder: (context, state) => PresentationPage(),
    ),
    GoRoute(
      path: Routes.verify,
      builder: (context, state) => VerifyPage(
        register: (state.extra as Map)["registerInfo"],
      ),
    ),
    GoRoute(
      path: Routes.balance,
      builder: (context, state) => BalancePage(),
    ),
  ],
);
