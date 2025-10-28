import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/icons.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final hasOpenedBefore = prefs.getBool('hasOpenedBefore') ?? false;

    if (hasOpenedBefore) {
      context.go(Routes.home);
    } else {
      await prefs.setBool('hasOpenedBefore', true);
      context.go(Routes.selectLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.splash),
            Text(
              "Talabajon",
              style: AppStyles.w600s50.copyWith(
                color: AppColors.indigoBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
