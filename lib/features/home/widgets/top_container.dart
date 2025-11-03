import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/core/utils/styles.dart';
import '../../../core/l10n/app_localizations.dart';
import 'small_svg_button.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      height: 225.h,
      padding: EdgeInsets.fromLTRB(21.w, 54.h, 20.w, 49.h),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [AppColors.indigoBlue, AppColors.blue],
          center: Alignment.center,
          radius: 0.88,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10.w,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name Lastname", style: AppStyles.w600s22w),
                      Row(
                        spacing: 5.w,
                        children: [
                          Text("ID: 1234567", style: AppStyles.w500s12w),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(const ClipboardData(text: "1234567"));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    spacing: 5,
                                    children: [
                                      SvgPicture.asset(
                                        AppSvgs.copy,
                                        colorFilter: const ColorFilter.mode(AppColors.hintText, BlendMode.srcIn),
                                      ),
                                      Text(local.text_been_copied_clipboard),
                                    ],
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              AppSvgs.copy,
                              width: 15.w,
                              height: 15.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 10.w,
                children: [
                  SmallSvgButton(svg: AppSvgs.notification),
                  SmallSvgButton(svg: AppSvgs.search),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.h,
                children: [
                  Text(local.balance, style: AppStyles.w400s12w),
                  Text("50 000 UZS", style: AppStyles.w600s22w),
                ],
              ),
              SmallSvgButton(svg: AppSvgs.share),
            ],
          ),
        ],
      ),
    );
  }
}
