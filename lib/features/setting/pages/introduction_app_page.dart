import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/titles.dart';
import 'package:talabajon/features/common/widgets/app_bar_common.dart';
import 'package:talabajon/features/common/widgets/custom_bottom_navigation_bar.dart';

import '../../../core/l10n/app_localizations.dart';

class IntroductionAppPage extends StatelessWidget {
  const IntroductionAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      appBar: AppBarCommon(title: local.introduction_app),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h),
          child: Text(Titles.introductionApp, style: AppStyles.w500s14),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(activeIndex: 3),
    );
  }
}
