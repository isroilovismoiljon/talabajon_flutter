import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/home/managers/me_bloc.dart';
import 'package:talabajon/features/home/managers/me_state.dart';
import '../../../core/l10n/app_localizations.dart';
import 'small_svg_button.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return BlocBuilder<MeBloc, MeState>(
      builder: (context, state) => Container(
        width: double.infinity,
        height: 225.h,
        padding: EdgeInsets.fromLTRB(21.w, 54.h, 20.w, 49.h),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [AppColors.indigoBlue, AppColors.blue],
            center: Alignment.center,
            radius: 0.88,
          ),
        ),
        child: state.meStatus == Status.loading
            ? Center(child: CircularProgressIndicator(color: AppColors.white))
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10.w,
                        children: [
                          state.userMe!.data.photo.isEmpty
                              ? Image.asset(
                                  "assets/photos/circle.png",
                                  width: 40.w,
                                  height: 40.h,
                                  fit: BoxFit.cover,
                                )
                              : CircleAvatar(
                                  radius: 20.w,
                                  backgroundImage: NetworkImage(state.userMe!.data.photo),
                                  backgroundColor: Colors.grey[200],
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 237.w,
                                child: Text(
                                  "${state.userMe!.data.firstName} ${state.userMe!.data.lastName}",
                                  style: AppStyles.w600s22w.copyWith(overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
                              ),
                              Row(
                                spacing: 5.w,
                                children: [
                                  Text("ID: ${state.userMe!.data.id}", style: AppStyles.w500s12w),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: "${state.userMe!.data.id}"));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            spacing: 5,
                                            children: [
                                              SvgPicture.asset(
                                                AppSvgs.copy,
                                                colorFilter: const ColorFilter.mode(AppColors.hintText, BlendMode.srcIn),
                                              ),
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
                                      width: 15.w,
                                      height: 15.h,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          SmallSvgButton(svg: AppSvgs.notification),
                          SmallSvgButton(svg: AppSvgs.search),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6.h,
                        children: [
                          Text(local.balance, style: AppStyles.w400s12w),
                          Text("${state.userMe!.data.balance} UZS", style: AppStyles.w600s22w),
                        ],
                      ),
                      SmallSvgButton(svg: AppSvgs.share),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
