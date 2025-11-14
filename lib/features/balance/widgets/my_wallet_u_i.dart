import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/balance/widgets/payments_widget.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/custom_button.dart';

class MyWalletUI extends StatefulWidget {
  const MyWalletUI({super.key});

  @override
  State<MyWalletUI> createState() => _MyWalletUIState();
}

class _MyWalletUIState extends State<MyWalletUI> with TickerProviderStateMixin {
  late final AnimationController transitionAnimationController;

  @override
  void initState() {
    super.initState();
    transitionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
  }

  @override
  void dispose() {
    transitionAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
      child: Column(
        children: [
          Container(
            width: 390.w,
            height: 194.h,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A3AFF), Color(0xFF7D5CFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(local.balance, style: AppStyles.w400s12w),
                Text("50 000 UZS", style: AppStyles.w500s24w),
                SizedBox(height: 18.h),
                Text("ID: 1234567", style: AppStyles.w500s16w),
                Spacer(),
                Text("Alisher Alisherov", style: AppStyles.w500s16w),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          CustomButton(title: local.top_up_account, width: 390, height: 51),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              local.payments,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 10.h),
          PaymentsWidget(
            transitionAnimationController: transitionAnimationController,
            local: local,
          ),
        ],
      ),
    );
  }
}
