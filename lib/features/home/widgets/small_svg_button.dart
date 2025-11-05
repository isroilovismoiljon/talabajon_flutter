import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';

class SmallSvgButton extends StatelessWidget {
  const SmallSvgButton({
    super.key,
    required this.svg,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 14,
    this.color = AppColors.border,
    this.onPressed = _defaultOnPressed,
  });

  final String svg;
  final double width, height, borderRadius;
  final Color color;
  final VoidCallback? onPressed;

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
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        padding: EdgeInsets.all(8),
        child: SvgPicture.asset(svg),
      ),
    );
  }
}
