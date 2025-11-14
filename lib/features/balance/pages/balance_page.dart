import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/common/widgets/app_bar_common.dart';
import 'package:talabajon/features/common/widgets/custom_button.dart';

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
      appBar: AppBarCommon(title: local.balance),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _tabTugmalar(),
            SizedBox(height: 20.h),
            Expanded(
              child: paymentTabActive ? _paymentBalansUI() : _myWalletUI(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(activeIndex: 1),
    );
  }

  Widget _tabTugmalar() {
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
                  "Payment Balans",
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
                  "My Wallet",
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

  Widget _paymentBalansUI() {
    final List<String> tolovTurlari = ["Humo", "Uzcard", "Click", "Payme"];
    return ListView(
      children: [
        for (final nom in tolovTurlari) ...[
          GestureDetector(
            onTap: () => setState(() => tanlanganTolov = nom),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.indigoBlue,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.credit_card, color: AppColors.indigoBlue),
                  SizedBox(width: 10.w),
                  Text(nom, style: AppStyles.w500s16.copyWith(color: AppColors.indigoBlue)),
                  const Spacer(),
                  Icon(
                    tanlanganTolov == nom ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: tanlanganTolov == nom ? AppColors.indigoBlue : AppColors.goldenYellow,
                  ),
                ],
              ),
            ),
          ),
          if (tanlanganTolov == nom)
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
              child: _cardInformation(),
            ),
        ],
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order total", style: AppStyles.w400s20),
            Text("123 500 UZS", style: AppStyles.w700s20),
          ],
        ),
        SizedBox(height: 15.h),
        CustomButton(
          title: "Payment Accept",
          width: 390,
          height: 51,
        ),
      ],
    );
  }

  Widget _myWalletUI() {
    return Column(
      children: [
        Container(
          width: double.infinity,
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
              Text(
                "Balans:",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              Text(
                "50 000 UZS",
                style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              Text(
                "ID: 1234567",
                style: TextStyle(color: Colors.white70, fontSize: 13.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "Alisher Alisherov",
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
            ],
          ),
        ),

        SizedBox(height: 15.h),
        CustomButton(
          title: "Hisobni to’ldirish",
          width: 390,
          height: 51,
        ),
        SizedBox(height: 20.h),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "To‘lovlar",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
        ),

        SizedBox(height: 10.h),

        Expanded(
          child: ListView(
            children: [
              _tolovItem("To‘lovingiz qabul qilindi", "13.03.2024 | 12:00", "5 000 UZS", true),
              _tolovItem("To‘lovingiz kutilmoqda", "14.03.2024 | 09:30", "10 000 UZS", false),
              _tolovItem("To‘lovingiz qabul qilindi", "15.03.2024 | 17:40", "25 000 UZS", true),
              _tolovItem("To‘lovingiz kutilmoqda", "16.03.2024 | 20:00", "15 000 UZS", false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardInformation() {
    return Container(
      margin: EdgeInsets.only(top: 15.h, bottom: 29.h),
      padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.blueW,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Card information", style: AppStyles.w500s24.copyWith(color: AppColors.indigoBlue)),
          SizedBox(height: 20.h),
          TextField(
            decoration: InputDecoration(
              hintText: "9860 1717 1717 1717",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 5.h),
          TextField(
            decoration: InputDecoration(
              hintText: "MM/YY",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
            keyboardType: TextInputType.datetime,
          ),
        ],
      ),
    );
  }

  Widget _tolovItem(String nom, String vaqt, String summa, bool qabulQilingan) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nom,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4.h),
              Text(
                vaqt,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
            ],
          ),
          Text(
            summa,
            style: TextStyle(
              color: qabulQilingan ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
