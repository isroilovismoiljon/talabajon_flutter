import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/icons.dart';
import 'package:talabajon/core/utils/styles.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({
    super.key,
    required this.svg,
    required this.title,
    this.onPressed = _defaultOnPressed,
  });

  final String svg, title;
  final VoidCallback onPressed;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 390.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 13.w,
              children: [
                SvgPicture.asset(svg),
                Text(title, style: AppStyles.w500s12),
              ],
            ),
            SvgPicture.asset(AppSvgs.rightArrow),
          ],
        ),
      ),
    );
  }
}
