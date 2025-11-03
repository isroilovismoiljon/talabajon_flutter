import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';

import '../../../core/l10n/app_localizations.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          local.enable_dark_mode,
          style: AppStyles.w500s14,
        ),
        SizedBox(
          height: 20.h,
          width: 37.w,
          child: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: _isDarkMode,
              activeColor: Colors.white,
              activeTrackColor: AppColors.black,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: AppColors.white,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
