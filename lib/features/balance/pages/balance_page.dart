import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import '../../common/widgets/app_bar_common.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        title: 'Balance',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(color: AppColors.indigoBlue, borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                children: [
                  Container(
                    child: Text('Something'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
