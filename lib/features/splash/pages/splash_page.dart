import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/home/managers/me_bloc.dart';
import 'package:talabajon/features/home/managers/me_event.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await _secureStorage.read(key: "token");

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      context.read<MeBloc>().add(MeEvent());
      context.go(Routes.home);
    } else {
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
            SvgPicture.asset(AppSvgs.splash),
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
