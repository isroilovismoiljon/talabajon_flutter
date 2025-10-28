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
    this.color = AppColors.indigoBlue,
    required this.title,
    required this.svg,
  });

  final VoidCallback? onPressed;
  final int width, height;
  final Color color;
  final String title, svg;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svg),
            Text(
              title,
              style: AppStyles.w600s16w,
            ),
          ],
        ),
      ),
    );
  }
}
