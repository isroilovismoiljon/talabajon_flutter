import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/data/models/auth/auth_response_model.dart';
import 'package:talabajon/data/models/verify/resend_verify_request_model.dart';
import 'package:talabajon/data/models/verify/verify_request_model.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_bloc.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_event.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_state.dart';
import 'package:talabajon/features/auth/managers/verify/verify_bloc.dart';
import 'package:talabajon/features/auth/managers/verify/verify_event.dart';
import 'package:talabajon/features/auth/managers/verify/verify_state.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/constants/status.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../widgets/verify_widget.dart';

class VerifyPage extends StatefulWidget {
  final AuthResponseModel register;

  const VerifyPage({
    super.key,
    required this.register,
  });

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  int secondsRemaining = 59;
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
                    content: Text(xabar, style: AppStyles.w600s18),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: AppColors.neonGreen,
                    duration: const Duration(seconds: 5),
                  ),
                );
              } else {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                    message: xabar,
                  ),
                  animationDuration: const Duration(milliseconds: 600),
                  displayDuration: const Duration(seconds: 5),
                );
              }
            }
          },
        ),
      ],
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/photos/img.png",
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: VerifyWidget(
                  enterTheCode: local.enter_the_code,
                  goToMinute: local.go_to_minute,
                  getTheCode: local.get_the_code,
                  verificationCodeHasBeenSent: local.verification_code_has_been_sent,
                  getCodeTitle: local.get_code,
                  secondsRemaining: secondsRemaining,
                  verificationCode: verificationCode,
                  telegramLink: telegramLink,
                  onResendTap: () {
                    context.read<ResendVerifyBloc>().add(
                      ResendVerifyPostEvent(
                        ResendVerifyRequestModel(
                          userId: widget.register.data!.user!.id!,
                        ),
                      ),
                    );
                  },
                  onVerifyCode: (enteredCode) {
                    context.read<VerifyBloc>().add(
                      VerifyPostEvent(
                        VerifyRequestModel(
                          userId: widget.register.data!.user!.id!,
                          verificationCode: enteredCode,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
