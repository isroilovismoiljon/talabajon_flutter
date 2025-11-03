import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/svgs.dart';

import '../../../core/utils/colors.dart';

class CustomTextFieldPassword extends StatefulWidget {
  const CustomTextFieldPassword({
    super.key,
    required this.controller,
    required this.icon,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint,icon;

  @override
  State<CustomTextFieldPassword> createState() => _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool passw = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      obscureText: passw,
      style: theme.textTheme.bodyLarge,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        prefixIcon: SizedBox(
          width: 24.w,
          height: 24.h,
          child: Center(
            child: SvgPicture.asset(
              widget.icon,
              width: 24.w,
              height: 24.h,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.hintText),
        suffixIcon: IconButton(
          onPressed: () {
            passw = !passw;
            setState(() {});
          },
          icon: passw
              ? SvgPicture.asset(
                  AppSvgs.eyeOn,
                  colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  AppSvgs.eyeOff,
                  colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                ),
        ),
      ),
    );
  }
}
