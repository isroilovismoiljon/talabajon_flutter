import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabajon/core/l10n/app_localizations.dart';
import 'package:talabajon/core/routing/router.dart';
import 'core/dependencies/bloc_dependencies.dart';
import 'core/dependencies/dependencies.dart';
import 'core/utils/themes.dart';
import 'features/common/managers/app_theme_cubit.dart';
import 'features/common/managers/localizatoin_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = SharedPreferencesAsync();
  final locale = await prefs.getString("locale") ?? "en";
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalizationCubit(locale: locale)),
        BlocProvider(create: (context) => AppThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themes = AppThemes();

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocalizationCubit>().state;
    final mode = context.watch<AppThemeCubit>().state;
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      ensureScreenSize: true,
      builder: (context, child) => MultiRepositoryProvider(
        providers: dependencies,
        child: MultiBlocProvider(
          providers: blocDependencies,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: locale,
            localizationsDelegates: MyLocalizations.localizationsDelegates,
            supportedLocales: MyLocalizations.supportedLocales,
            theme: themes.lightTheme,
            darkTheme: themes.darkTheme,
            themeMode: mode,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
