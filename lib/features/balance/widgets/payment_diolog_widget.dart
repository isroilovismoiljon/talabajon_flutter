import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/data/models/paymets/my_payments_model.dart';

class PaymentDialogWidget extends StatelessWidget {
  const PaymentDialogWidget({
    super.key,
    required this.payment,
  });

  final PaymentData payment;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.r),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            Center(
              child: Container(
                width: 146.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(),
            Text(
              "Kvintatsiya",
              style: AppStyles.w500s24,
            ),
            Container(
              width: 368.w,
              height: 535.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: AppColors.hintText,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.network(
                  payment.photo,
                  width: 368.w,
                  height: 535.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
