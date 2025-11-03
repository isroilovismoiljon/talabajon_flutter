import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field.dart';
import 'package:talabajon/features/common/widgets/custom_button.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/custom_bottom_navigation_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 69.h, 20.w, 0),
        child: Column(
          spacing: 21.h,
          children: [
            Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: AppColors.disabledButton,
                shape: BoxShape.circle
              ),
            ),
            SizedBox(),
            Column(
              spacing: 10.h,
              children: [
                CustomTextField(controller: firstnameController, icon: AppSvgs.account, hintText: local.first_name,svgColor: AppColors.hintText,),
                CustomTextField(controller: lastnameController, icon: AppSvgs.account, hintText: local.last_name,svgColor: AppColors.hintText,),
                CustomTextField(controller: usernameController, icon: AppSvgs.userName, hintText: local.username,svgColor: AppColors.hintText,),
                CustomTextField(controller: phoneNumberController, icon: AppSvgs.phone, hintText: local.phone_number,svgColor: AppColors.hintText,)
              ],
            ),
            CustomButton(title: local.update_profile),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(activeIndex: 3),
    );
  }
}
