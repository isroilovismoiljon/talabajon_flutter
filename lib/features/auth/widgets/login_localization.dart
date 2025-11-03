import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/common/managers/localizatoin_cubit.dart';

class LoginLocalization extends StatelessWidget {
  const LoginLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCubit = context.watch<LocalizationCubit>();
    final currentLocale = localizationCubit.currentLocale;

    String flag;
    String label;

    switch (currentLocale) {
      case 'ru':
        flag = AppSvgs.rus;
        label = "RU";
        break;
      case 'en':
        flag = AppSvgs.eng;
        label = "EN";
        break;
      default:
        flag = AppSvgs.uzb;
        label = "UZ";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onSelected: (value) async {
            await localizationCubit.changeLocale(locale: value);
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'uz',
              child: Row(
                children: [
                  SvgPicture.asset(AppSvgs.uzb, width: 24.w),
                  SizedBox(width: 8.w),
                  const Text("Oʻzbek"),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'ru',
              child: Row(
                children: [
                  SvgPicture.asset(AppSvgs.rus, width: 24.w),
                  SizedBox(width: 8.w),
                  const Text("Русский"),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'en',
              child: Row(
                children: [
                  SvgPicture.asset(AppSvgs.eng, width: 24.w),
                  SizedBox(width: 8.w),
                  const Text("English"),
                ],
              ),
            ),
          ],
          child: Row(
            children: [
              SvgPicture.asset(flag, width: 24.w),
              SizedBox(width: 6.w),
              Text(label, style: AppStyles.w400s16),
              const Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
        ),
      ],
    );
  }
}
