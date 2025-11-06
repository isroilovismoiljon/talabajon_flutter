import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/auth/managers/login/login_bloc.dart';
import 'package:talabajon/features/auth/managers/login/login_state.dart';
import 'package:talabajon/features/auth/widgets/rich_text_sec_title.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field_password.dart';

import '../../../core/l10n/app_localizations.dart';
import '../widgets/login_button.dart';
import '../widgets/login_localization.dart';

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

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == Status.success) {
          final loginData = state.login?.data;
          if (loginData?.success == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("✅ ${loginData?.message ?? "Login successful"}"),
              ),
            );
            context.go(Routes.home);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("❎ ${loginData?.message ?? "Login failed"}"),
              ),
            );
          }
        } else if (state.loginStatus == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.errorMessage}")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const LoginLocalization(),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                  style: AppStyles.w400s12,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6.h),
                Column(
                  spacing: 10.h,
                  children: [
                    CustomTextField(
                      controller: usernameController,
                      icon: AppSvgs.userName,
                      hintText: local.username,
                    ),
                    CustomTextFieldPassword(
                      controller: passwordController,
                      icon: AppSvgs.password,
                      hint: local.password,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                LoginButton(
                  usernameController: usernameController,
                  passwordController: passwordController,
                ),
                SizedBox(height: 5.h),
                RichTextSecTitle(title1: local.dont_have_account, title2: local.sign_up,onPressed: (){context.go(Routes.register);}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
