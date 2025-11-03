import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/core/utils/styles.dart';
import '../../../core/l10n/app_localizations.dart';
import 'service_button.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Align(
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
            Text(local.popularity_service, style: AppStyles.w600s22),
            Column(
              spacing: 7.5.h,
              children: [
                ServiceButton(svg: AppSvgs.powerPoint, title: local.prepare_presentation,onPressed: (){context.push(Routes.createPresentation);},),
                ServiceButton(svg: AppSvgs.word, title: local.do_independent_assignment),
                ServiceButton(svg: AppSvgs.word, title: local.write_report),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
