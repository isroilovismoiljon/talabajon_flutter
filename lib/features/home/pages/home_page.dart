import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/home/widgets/service_button.dart';
import 'package:talabajon/features/home/widgets/small_svg_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                          decoration: BoxDecoration(
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
                                    Clipboard.setData(ClipboardData(text: "1234567"));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          spacing: 5,
                                          children: [
                                            SvgPicture.asset(
                                              AppSvgs.copy,
                                              colorFilter: ColorFilter.mode(AppColors.hintText, BlendMode.srcIn),
                                            ),
                                            Text("Matn vaqtincha xotiraga nusxalandi ✅"),
                                          ],
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        duration: const Duration(seconds: 2),
                                        animation: CurvedAnimation(
                                          parent: AnimationController(
                                            vsync: Navigator.of(context),
                                            duration: const Duration(milliseconds: 700),
                                          ),
                                          curve: Curves.easeOutBack,
                                        ),
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    AppSvgs.copy,
                                    width: 15.w,
                                    height: 15.h,
                                    colorFilter: ColorFilter.mode(
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
                        Text("Balans:", style: AppStyles.w400s12w),
                        Text("50 000 UZS", style: AppStyles.w600s22w),
                      ],
                    ),
                    SmallSvgButton(svg: AppSvgs.share),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 719.h,
              padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 25.h),
              decoration: BoxDecoration(
                color: AppColors.home,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                spacing: 15.h,
                children: [
                  Text("Popularity service", style: AppStyles.w600s22),
                  Column(
                    spacing: 7.5.h,
                    children: [
                      ServiceButton(svg: AppSvgs.powerPoint, title: 'Taqdimot tayorlash'),
                      ServiceButton(svg: AppSvgs.word, title: 'Mustaqil ish tayorlash'),
                      ServiceButton(svg: AppSvgs.word, title: 'Referat tayorlash'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
