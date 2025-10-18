import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/icons.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameController,
    required this.icon,
    required this.hintText,
  });

  final TextEditingController nameController;
  final String icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        suffixIcon: SvgPicture.asset(
          icon,
          width: 20.w,
          height: 20.h,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.hintText),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
        ),
      ),
    );
  }
}
