import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/styles.dart';
import '../../../core/utils/colors.dart';

class CustomEmptyField extends StatelessWidget {
  const CustomEmptyField({
    super.key,
    required this.controller,
    required this.titleHint,
    this.maxLines = 1,
    this.width = 390,
    this.border = 5,
    this.align = TextAlign.start,
    this.style = AppStyles.w400s16,
  });

  final TextEditingController controller;
  final String titleHint;
  final double width, border;
  final int maxLines;
  final TextAlign align;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: style,
      textAlign: align,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        constraints: BoxConstraints(
          minWidth: 125.w,
          maxWidth: width.w,
        ),
        hintText: titleHint,
        hintStyle: TextStyle(color: AppColors.hintText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
