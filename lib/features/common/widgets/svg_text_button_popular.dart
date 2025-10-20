import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/icons.dart';

import '../../../core/routing/routes.dart';

class SvgTextButtonPopular extends StatefulWidget {
  const SvgTextButtonPopular({
    super.key,
    this.onPressed,
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
  State<SvgTextButtonPopular> createState() => _SvgTextButtonPopularState();
}

class _SvgTextButtonPopularState extends State<SvgTextButtonPopular> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed ?? () => context.push(Routes.register),
      child: Container(
        width: widget.width.w,
        height: widget.height.h,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(widget.svg),
            Text(
              widget.title,
              style: AppStyles.w600s16w,
            ),
          ],
        ),
      ),
    );
  }
}
