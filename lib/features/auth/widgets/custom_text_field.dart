import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';

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
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        prefixIcon: SizedBox(
          width: 24.w,
          height: 24.h,
          child: Center(
            child: SvgPicture.asset(
              icon,
            ),
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.hintText),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: BorderSide(color: AppColors.border)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide(color: AppColors.border)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: BorderSide(color: AppColors.border)
        ),
      ),
    );
  }
}
