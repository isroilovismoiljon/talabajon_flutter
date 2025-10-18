import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';

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
      path: Routes.selectLanguage,
      builder: (context, state) => SelectLanguagePage(),
    ),
  ],
);
