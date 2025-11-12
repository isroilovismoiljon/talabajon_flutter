import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/svgs.dart';
import '../../../../core/utils/styles.dart';
import '../../../../features/common/widgets/custom_svg_button.dart';

class VerifyWidget extends StatefulWidget {
  final String enterTheCode;
  final String goToMinute;
  final String getTheCode;
  final String verificationCodeHasBeenSent;
  final String getCodeTitle;
  final int secondsRemaining;
  final String? telegramLink;
  final String? verificationCode;
  final VoidCallback onResendTap;
  final Function(String enteredCode) onVerifyCode;

  const VerifyWidget({
    super.key,
    required this.enterTheCode,
    required this.goToMinute,
    required this.getTheCode,
    required this.verificationCodeHasBeenSent,
    required this.getCodeTitle,
    required this.secondsRemaining,
    required this.onResendTap,
    required this.onVerifyCode,
    this.verificationCode,
    this.telegramLink,
  });

  @override
  State<VerifyWidget> createState() => _VerifyWidgetState();
}

class _VerifyWidgetState extends State<VerifyWidget> {
  String kod = "";
  bool? isCodeCorrect;

  @override
  Widget build(BuildContext context) {
    final timerText = widget.secondsRemaining > 0 ? "0:${widget.secondsRemaining.toString().padLeft(2, '0')}" : "Resend code";

    return Container(
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
            widget.enterTheCode,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            widget.goToMinute,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            widget.getTheCode,
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
                final correctCode = widget.verificationCode;
                setState(() {
                  isCodeCorrect = enteredCode == correctCode;
                });
                if (isCodeCorrect == true) {
                  widget.onVerifyCode(enteredCode);
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
                  text: widget.verificationCodeHasBeenSent,
                  style: AppStyles.w400s12,
                ),
                TextSpan(
                  text: "  $timerText",
                  style: AppStyles.w600s10.copyWith(
                    decoration: widget.secondsRemaining > 0 ? null : TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = widget.secondsRemaining > 0 ? null : widget.onResendTap,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          CustomSvgButton(
            title: widget.getCodeTitle,
            svg: AppSvgs.telegram,
            width: 262,
            height: 60,
            border: 16,
            onPressed: widget.secondsRemaining > 0
                ? () async {
                    if (widget.telegramLink != null) {
                      final Uri url = Uri.parse(widget.telegramLink!);
                      await launchUrl(url);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}