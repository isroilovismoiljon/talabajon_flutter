import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/data/models/auth/login_request_model.dart';
import 'package:talabajon/features/auth/managers/login/login_bloc.dart';
import 'package:talabajon/features/auth/managers/login/login_event.dart';
import 'package:talabajon/features/auth/managers/login/login_state.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field_password.dart';
import 'package:talabajon/features/common/managers/localizatoin_cubit.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/colors.dart';

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
        flag = AppSvgs.rus;
        label = "RU";
        break;
      case 'en':
        flag = AppSvgs.eng;
        label = "EN";
        break;
      default:
        flag = AppSvgs.uzb;
        label = "UZ";
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == Status.success) {
          final loginData = state.login?.data;
          if (loginData?.success == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("✅ ${loginData?.message ?? "Login successful"}"),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                duration: const Duration(seconds: 5),
              ),
            );
            context.go(Routes.home);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("❎ ${loginData?.message ?? "Login failed"}"),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        } else if (state.loginStatus == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${state.errorMessage}"),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: Scaffold(
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
                        SvgPicture.asset(AppSvgs.uzb, width: 24.w),
                        SizedBox(width: 8.w),
                        const Text("Oʻzbek"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'ru',
                    child: Row(
                      children: [
                        SvgPicture.asset(AppSvgs.rus, width: 24.w),
                        SizedBox(width: 8.w),
                        const Text("Русский"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        SvgPicture.asset(AppSvgs.eng, width: 24.w),
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
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  final isLoading = state.loginStatus == Status.loading;
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: usernameController,
                    builder: (context, usernameValue, _) {
                      return ValueListenableBuilder<TextEditingValue>(
                        valueListenable: passwordController,
                        builder: (context, passwordValue, _) {
                          final isDisabled = isLoading || usernameValue.text.trim().isEmpty || passwordValue.text.trim().isEmpty;

                          return CustomSvgButton(
                            title: isLoading ? 'Loading...' : local.login,
                            svg: AppSvgs.logout,
                            width: 390,
                            height: 60,
                            onPressed: isDisabled
                                ? null
                                : () {
                                    context.read<LoginBloc>().add(
                                      LoginPostEvent(
                                        LoginRequestModel(
                                          username: usernameValue.text.trim(),
                                          password: passwordValue.text.trim(),
                                        ),
                                      ),
                                    );
                                  },
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 5.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: AppStyles.w400s12,
                    children: [
                      TextSpan(
                        text: "Don’t have an account? ",
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: AppStyles.w500s12.copyWith(color: AppColors.indigoBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(Routes.register);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
