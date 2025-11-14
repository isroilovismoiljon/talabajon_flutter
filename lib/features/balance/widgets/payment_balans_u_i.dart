import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/models/paymets/payment_model.dart';
import 'package:talabajon/features/balance/managers/payment/payment_bloc.dart';
import 'package:talabajon/features/balance/managers/payment/payment_event.dart';
import 'package:talabajon/features/balance/managers/payment/payment_state.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/svgs.dart';
import '../../common/widgets/custom_svg_button.dart';

class PaymentBalanceUI extends StatefulWidget {
  const PaymentBalanceUI({super.key});

  @override
  State<PaymentBalanceUI> createState() => _PaymentBalanceUIState();
}

class _PaymentBalanceUIState extends State<PaymentBalanceUI> {
  File? tanlanganRasm;
  final TextEditingController summaController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool get _canSend => tanlanganRasm != null && summaController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    summaController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    summaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state.paymentStatus == Status.success) {
          final paymentData = state.payment!;
          if (paymentData.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("✅ ${paymentData.message}"),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("❎ ${paymentData.message}"),
              ),
            );
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 104.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 18.h),
              Text(
                local.make_payment_card_numbers_below_upload_receipt,
                style: AppStyles.w500s20,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18.h),
              Container(
                width: 390.w,
                height: 68.h,
                decoration: BoxDecoration(
                  color: AppColors.indigoBlue,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("9860 2000 0001 007", style: AppStyles.w500s16w),
                        Text("Alisherov Alisher", style: AppStyles.w400s14w),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: "9860 2000 0001 007"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                SvgPicture.asset(
                                  AppSvgs.copy,
                                  colorFilter: const ColorFilter.mode(AppColors.hintText, BlendMode.srcIn),
                                ),
                                SizedBox(width: 5.w),
                                Text(local.text_been_copied_clipboard),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        AppSvgs.copy,
                        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              GestureDetector(
                onTap: () async {
                  final XFile? rasm = await _picker.pickImage(source: ImageSource.gallery);
                  if (rasm != null) {
                    setState(() {
                      tanlanganRasm = File(rasm.path);
                    });
                  }
                },
                child: Container(
                  width: 390.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.indigoBlue, width: 1.5),
                    borderRadius: BorderRadius.circular(34.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppSvgs.image,
                        height: 20.h,
                        colorFilter: const ColorFilter.mode(AppColors.hintText, BlendMode.srcIn),
                      ),
                      Text(
                        local.upload_payment,
                        style: AppStyles.w500s16.copyWith(color: AppColors.hintText),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              if (tanlanganRasm != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    tanlanganRasm!,
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: 390.w,
                  height: 55.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: summaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: local.enter_amount_from_the_receipt,
                            hintStyle: AppStyles.w400s14.copyWith(color: AppColors.hintText),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text("UZS", style: AppStyles.w400s14),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 50.h),
              CustomSvgButton(
                title: local.send,
                svg: AppSvgs.send,
                width: 390,
                height: 54,
                onPressed: _canSend
                    ? () {
                        context.read<PaymentBloc>().add(
                          PaymentNewEvent(
                            data: PaymentModel(
                              requestedAmount: int.tryParse(summaController.text)!,
                              photo: tanlanganRasm,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
