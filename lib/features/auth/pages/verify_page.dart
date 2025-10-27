import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/icons.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/otp_input.dart';
import '../widgets/envelope_icon.dart';

class VerifyPage extends StatefulWidget {
  final String? telegramBotLink;

  const VerifyPage({
    super.key,
    this.telegramBotLink,
  });

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  int _secondsRemaining = 119; // 1:59
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

  Future<void> _openTelegramBot() async {
    final botLink = widget.telegramBotLink ?? 'https://t.me/Talabajon_services_bot?start=8575';
    final Uri url = Uri.parse(botLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Telegram botni ochib bo\'lmadi')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 44.w, vertical: 174.h),
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                const EnvelopeIcon(),
                SizedBox(height: 32.h),

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

              // Code input boxes
              const OtpInput(
                length: 4,
                correctOtp: '1122',
              ),
                SizedBox(height: 16.h),

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
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _openTelegramBot,
                    icon: SvgPicture.asset(AppIcons.telegram, width: 24.w, height: 24.h,),
                    label: const Text(
                      'Kodni olish',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D3BF3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
