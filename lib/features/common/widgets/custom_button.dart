import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed = _defaultOnPressed,
    this.width = 390,
    this.height = 62,
    required this.title,
    this.color = AppColors.indigoBlue,
    this.style = AppStyles.w600s18w,
    this.border = false,
    this.borderRadius = 10,
  });

  final VoidCallback? onPressed;
  final double width, height, borderRadius;
  final String title;
  final Color color;
  final TextStyle style;
  final bool border;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.disabledButton,
        disabledForegroundColor: AppColors.hintText,
        fixedSize: Size(width.w, height.h),
        side: border ? const BorderSide(color: AppColors.border, width: 1.5) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: style,
      ),
    );
  }
}
