import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/icons.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/data/models/auth/register_response_model.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int _secondsRemaining = 119;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String get _timerText {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String kod = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // Icon
                SizedBox(width: 166.w, height: 165.h, child: Image.asset("assets/photos/mail.png")),
                SizedBox(height: 11.5.h),

                // Title
                const Text(
                  'Kodni kiriting',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 12.h),
                const Text(
                  'Quyidagi telegram botga kiring va\n2 daqiqalik kodingizni oling',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF666666),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),

                // "Kodni oling" label
                const Text(
                  'Kodni oling',
                  style: TextStyle(
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
                    onChanged: (val) => setState(() => kod = val),
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10.r),
                      fieldHeight: 42.7.h,
                      fieldWidth: 36.w,
                      activeColor: AppColors.white,
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

                // Timer
                Text(
                  'Tasdiqlash kodi jo\'natildi: $_timerText',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 32.h),
                // Button
                CustomSvgButton(
                  title: "Kodni olish",
                  svg: AppIcons.telegram,
                  width: 262,
                  height: 60,
                  border: 16,
                  onPressed: () async {
                    final Uri url = Uri.parse(widget.register.data?.telegramDeepLink ?? '');
                    await launchUrl(url);
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
