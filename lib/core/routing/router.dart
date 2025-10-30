import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/features/auth/pages/login_page.dart';
import 'package:talabajon/features/auth/pages/register_page.dart';
import 'package:talabajon/features/auth/pages/verify_page.dart';
import 'package:talabajon/features/home/pages/home_page.dart';

import '../../features/splash/pages/select_lang_page.dart';
import '../../features/splash/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: Routes.register,

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
      path: Routes.verify,
      builder: (context, state) => VerifyPage(
        register: (state.extra as Map)["registerInfo"],
      ),
    ),
  ],
);
