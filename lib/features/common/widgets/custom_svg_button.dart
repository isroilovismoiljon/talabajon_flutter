import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';

class CustomSvgButton extends StatelessWidget {
  const CustomSvgButton({
    super.key,
    this.onPressed = _defaultOnPressed,
    this.width = 290,
    this.height = 45,
    this.border = 7,
    this.color = AppColors.indigoBlue,
    required this.title,
    required this.svg,
    this.style = AppStyles.w600s16w,
  });

  final VoidCallback? onPressed;
  final double width, height, border;
  final Color color;
  final TextStyle style;
  final String title, svg;

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            border.r,
          ),
        ),
        side: BorderSide(color: AppColors.indigoBlue, width: 2),
      ),
      onPressed: onPressed,
      child: Row(
        spacing: 10.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svg,
          ),
          Text(
            title,
            style: style,
          ),
        ],
      ),
    );
  }
}
