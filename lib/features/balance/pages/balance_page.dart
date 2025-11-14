import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/balance/widgets/my_wallet_u_i.dart';
import 'package:talabajon/features/balance/widgets/payment_balans_u_i.dart';
import 'package:talabajon/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/custom_bottom_navigation_bar.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  String? tanlanganTolov;
  bool paymentTabActive = true;

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      appBar: AppBarCommon(title: local.balanceBottom),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: _tabTugmalar(),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: paymentTabActive ? PaymentBalanceUI() : MyWalletUI(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(activeIndex: 1),
    );
  }

  Widget _tabTugmalar() {
    final local = MyLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.indigoBlue,
        borderRadius: BorderRadius.circular(5.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => paymentTabActive = true),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.5.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: paymentTabActive ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  local.payment_balance,
                  style: AppStyles.w500s14.copyWith(
                    color: !paymentTabActive ? AppColors.white : AppColors.indigoBlue,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => paymentTabActive = false),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.5.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: !paymentTabActive ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  local.my_wallet,
                  style: AppStyles.w500s14.copyWith(
                    color: !paymentTabActive ? AppColors.indigoBlue : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
