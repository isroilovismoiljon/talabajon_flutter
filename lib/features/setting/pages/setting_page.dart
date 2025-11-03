import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import 'package:talabajon/features/setting/widget/setting_widget.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/styles.dart';
import '../widget/account_app_bar.dart';
import '../widget/language_bottom_sheet.dart';
import '../widget/theme_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AccountAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 0),
        child: Column(
          spacing: 18.h,
          children: [
            ThemeWidget(),
            Column(
              spacing: 10.h,
              children: [
                SettingWidget(
                  title: local.settings_profile,
                  svg: AppSvgs.profile,
                  onPressed: () {
                    context.go(Routes.profile);
                  },
                ),
                SettingWidget(title: local.referral_system, svg: AppSvgs.referral),
                SettingWidget(
                  title: local.introduction_app,
                  svg: AppSvgs.introduction,
                  rightSvg: false,
                  onPressed: () {
                    context.go(Routes.introductionApp);
                  },
                ),
                SettingWidget(title: local.share_friends, svg: AppSvgs.share, rightSvg: false),
                SettingWidget(title: local.contact_us, svg: AppSvgs.contact, rightSvg: false),
                SettingWidget(
                  title: local.language,
                  svg: AppSvgs.language,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                      ),
                      builder: (context) => LanguageBottomSheet(),
                    );
                  },
                ),
                SettingWidget(title: local.about, svg: AppSvgs.about),
              ],
            ),
            CustomSvgButton(
              title: local.log_out,
              svg: AppSvgs.logout,
              width: 390,
              height: 60,
              color: Colors.transparent,
              style: AppStyles.w600s16.copyWith(color: AppColors.indigoBlue),
              onPressed: () {
                context.go(Routes.login);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(activeIndex: 3),
    );
  }
}
