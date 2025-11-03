import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/svgs.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key,
    required this.title,
    required this.svg,
    this.onPressed = _defaultOnPressed,
    this.rightSvg = true,
  });

  final String title, svg;
  final bool rightSvg;
  final VoidCallback onPressed;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(6.r),
          border: BoxBorder.all(color: AppColors.indigoBlue, width: 1.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10.w,
              children: [
                SvgPicture.asset(svg),
                Text(title, style: AppStyles.w500s14),
              ],
            ),
            rightSvg ? SvgPicture.asset(AppSvgs.rightArrow) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
