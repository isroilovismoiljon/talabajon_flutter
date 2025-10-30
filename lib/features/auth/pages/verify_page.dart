import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/icons.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/data/models/auth/register_response_model.dart';
import 'package:talabajon/data/models/verify/resend_verify_request_model.dart';
import 'package:talabajon/data/models/verify/verify_request_model.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_bloc.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_event.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_state.dart';
import 'package:talabajon/features/auth/managers/verify/verify_bloc.dart';
import 'package:talabajon/features/auth/managers/verify/verify_event.dart';
import 'package:talabajon/features/auth/managers/verify/verify_state.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/status.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';

class VerifyPage extends StatefulWidget {
  final RegisterResponseModel register;

  const VerifyPage({
    super.key,
    required this.register,
  });

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  int secondsRemaining = 56;
  Timer? timer;
  String kod = "";
  bool? isCodeCorrect;

  String? verificationCode;
  String? telegramLink;

  @override
  void initState() {
    super.initState();
    startTimer();

    verificationCode = widget.register.data?.verificationCode;
    telegramLink = widget.register.data?.telegramDeepLink;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String get timerText {
    if (secondsRemaining <= 0) return "Reset code";
    int minutes = secondsRemaining ~/ 60;
    int seconds = secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return MultiBlocListener(
      listeners: [
        BlocListener<VerifyBloc, VerifyState>(
          listener: (context, state) {
            if (state.verifyStatus == Status.success) {
              state.verify!.data.success
                  ? context.go(Routes.login)
                  : showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Ogohlantirish"),
                          content: Text(state.verify!.data.message),
                          actions: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
            } else if (state.verifyStatus == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("error: ${state.errorMessage}")),
              );
            }
          },
        ),
        BlocListener<ResendVerifyBloc, ResendVerifyState>(
          listener: (context, state) {
            if (state.resendStatus == Status.success) {
              final muvaffaqiyat = state.resend!.data.success;
              final xabar = state.resend!.data.message ?? "Natija noma'lum";
              if (muvaffaqiyat) {
                setState(() {
                  verificationCode = state.resend!.data.verificationCode ?? verificationCode;
                  telegramLink = state.resend!.data.telegramDeepLink ?? telegramLink;
                  secondsRemaining = 59;
                  startTimer();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      xabar,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: Colors.green.shade600,
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                    message: xabar,
                  ),
                  animationDuration: const Duration(milliseconds: 600),
                  displayDuration: const Duration(seconds: 3),
                );
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 44.w, vertical: 17.h),
              padding: EdgeInsets.all(32.r),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 166.w,
                    height: 165.h,
                    child: Image.asset("assets/photos/mail.png"),
                  ),
                  SizedBox(height: 11.5.h),
                  Text(
                    local.enter_the_code,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    local.go_to_minute,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    local.get_the_code,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 46.w),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      onChanged: (val) {
                        setState(() {
                          kod = val;
                          isCodeCorrect = null;
                        });
                      },
                      onCompleted: (enteredCode) {
                        final correctCode = verificationCode;
                        setState(() {
                          isCodeCorrect = enteredCode == correctCode;
                        });
                        if (isCodeCorrect == true) {
                          context.read<VerifyBloc>().add(
                            VerifyPostEvent(
                              VerifyRequestModel(
                                userId: widget.register.data!.user!.id!,
                                verificationCode: enteredCode,
                              ),
                            ),
                          );
                        }
                      },
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10.r),
                        fieldHeight: 42.7.h,
                        fieldWidth: 36.w,
                        activeColor: isCodeCorrect == null
                            ? AppColors.white
                            : isCodeCorrect == true
                            ? Colors.green
                            : Colors.red,
                        selectedColor: AppColors.black,
                        inactiveColor: AppColors.white,
                        activeFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                      ),
                      textStyle: AppStyles.w400s16,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: local.verification_code_has_been_sent,
                          style: AppStyles.w400s12,
                        ),
                        TextSpan(
                          text: secondsRemaining > 0 ? "  $timerText" : "  Resend code",
                          style: AppStyles.w600s10.copyWith(
                            decoration: secondsRemaining > 0 ? null : TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = secondsRemaining > 0
                                ? null
                                : () {
                                    context.read<ResendVerifyBloc>().add(
                                      ResendVerifyPostEvent(
                                        ResendVerifyRequestModel(
                                          userId: widget.register.data!.user!.id!,
                                        ),
                                      ),
                                    );
                                  },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomSvgButton(
                    title: local.get_code,
                    svg: AppSvgs.telegram,
                    width: 262,
                    height: 60,
                    border: 16,
                    onPressed: () async {
                      if (telegramLink != null) {
                        final Uri url = Uri.parse(telegramLink!);
                        await launchUrl(url);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
