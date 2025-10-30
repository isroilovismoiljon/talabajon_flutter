import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/icons.dart';

class SmallSvgButton extends StatelessWidget {
  const SmallSvgButton({
    super.key,
    required this.svg,
    this.onPressed = _defaultOnPressed,
  });

  final String svg;
  final VoidCallback onPressed;
  static void _defaultOnPressed() {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(14.r),
        ),
        padding: EdgeInsets.all(8),
        child: SvgPicture.asset(svg),
      ),
    );
  }
}
