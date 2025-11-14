import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/data/models/paymets/my_payments_model.dart';
import 'package:talabajon/features/balance/widgets/payment_diolog_widget.dart';

import '../../../core/l10n/app_localizations.dart';

class PaymentPaymentInfo extends StatelessWidget {
  const PaymentPaymentInfo({
    super.key,
    required this.transitionAnimationController,
    required this.payment,
    required this.local,
    required this.formatDate,
  });

  final AnimationController transitionAnimationController;
  final PaymentData payment;
  final MyLocalizations local;
  final String formatDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              transitionAnimationController: transitionAnimationController,
              builder: (_) => PaymentDialogWidget(payment: payment),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 54.h,
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
                        width: 48.w,
                        height: 54.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.paymentStatus == 2
                            ? local.your_payment_has_been_received
                            : payment.paymentStatus == 0
                            ? local.your_payment_is_pending
                            : local.your_payment_was_not_accepted,
                        style: AppStyles.w400s12.copyWith(
                          color: AppColors.hintText,
                        ),
                      ),
                      Text(
                        formatDate,
                        style: AppStyles.w400s12.copyWith(
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "${payment.requestedAmount} UZS",
                style: AppStyles.w600s20.copyWith(
                  color: payment.paymentStatus == 2
                      ? AppColors.neonGreen
                      : payment.paymentStatus == 0
                      ? AppColors.goldenYellow
                      : AppColors.crimsonRed,
                ),
              ),
            ],
          ),
        ),
        Divider(color: AppColors.hintText),
      ],
    );
  }
}
