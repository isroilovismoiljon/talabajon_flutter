import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talabajon/core/utils/icons.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field.dart';
import 'package:talabajon/features/common/managers/localizatoin_cubit.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';

import '../../../core/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    final localizationCubit = context.watch<LocalizationCubit>();
    final currentLocale = localizationCubit.currentLocale;

    String flag;
    String label;

    switch (currentLocale) {
      case 'ru':
        flag = AppIcons.rus;
        label = "RU";
        break;
      case 'en':
        flag = AppIcons.eng;
        label = "EN";
        break;
      default:
        flag = AppIcons.uzb;
        label = "UZ";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (value) async {
                await localizationCubit.changeLocale(locale: value);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'uz',
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.uzb, width: 24.w),
                      SizedBox(width: 8.w),
                      const Text("Oʻzbek"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'ru',
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.rus, width: 24.w),
                      SizedBox(width: 8.w),
                      const Text("Русский"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'en',
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.eng, width: 24.w),
                      SizedBox(width: 8.w),
                      const Text("English"),
                    ],
                  ),
                ),
              ],
              child: Row(
                children: [
                  SvgPicture.asset(flag, width: 24.w),
                  SizedBox(width: 6.w),
                  Text(label, style: AppStyles.w400s16),
                  const Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10.h,
          children: [
            Image.asset(
              "assets/photos/login_image.png",
              width: 253.28.w,
              height: 350.h,
              fit: BoxFit.cover,
            ),
            Text(
              local.welcome_to_talabajon,
              style: AppStyles.w700s24,
              textAlign: TextAlign.center,
            ),
            Text(
              local.log_in_your_account_use_the_app,
              style: AppStyles.w400s10,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h),
            Column(
              spacing: 10.h,
              children: [
                CustomTextField(nameController: usernameController, icon: AppIcons.userName, hintText: local.username),
                CustomTextField(nameController: passwordController, icon: AppIcons.password, hintText: local.password),
              ],
            ),
            SizedBox(height: 10.h),
            CustomSvgButton(
              title: local.login,
              svg: AppIcons.logout,
              width: 390,
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
