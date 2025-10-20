import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/icons.dart';
import 'package:talabajon/features/common/managers/localizatoin_cubit.dart';
import 'package:talabajon/features/common/widgets/svg_text_button_popular.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 10.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please select your language",
              style: AppStyles.w700s24,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            SvgTextButtonPopular(
              title: 'Oʻzbek',
              svg: AppIcons.uzb,
              onPressed: () {
                context.read<LocalizationCubit>().changeLocale(locale: 'uz');
                context.push(Routes.register);
              },
            ),

            SvgTextButtonPopular(
              title: 'Русский',
              svg: AppIcons.rus,
              onPressed: () {
                context.read<LocalizationCubit>().changeLocale(locale: 'ru');
                context.push(Routes.register);
              },
            ),

            SvgTextButtonPopular(
              title: 'English',
              svg: AppIcons.eng,
              onPressed: () {
                context.read<LocalizationCubit>().changeLocale(locale: 'en');
                context.push(Routes.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}
