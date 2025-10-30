import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/icons.dart';
import 'package:talabajon/features/common/managers/localizatoin_cubit.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';

import '../../../core/l10n/app_localizations.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 10.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              local.please_select_language_for_app,
              style: AppStyles.w700s24,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            CustomSvgButton(
              title: 'Oʻzbek',
              svg: AppSvgs.uzb,
              onPressed: () {
                context.read<LocalizationCubit>().changeLocale(locale: 'uz');
                context.push(Routes.register);
              },
            ),

            CustomSvgButton(
              title: 'Русский',
              svg: AppSvgs.rus,
              onPressed: () {
                context.read<LocalizationCubit>().changeLocale(locale: 'ru');
                context.push(Routes.register);
              },
            ),

            CustomSvgButton(
              title: 'English',
              svg: AppSvgs.eng,
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
