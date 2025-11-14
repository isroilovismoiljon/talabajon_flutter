import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/home/managers/me_bloc.dart';
import 'package:talabajon/features/home/managers/me_state.dart';

import '../../../core/l10n/app_localizations.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return BlocBuilder<MeBloc, MeState>(
      builder: (context, state) => AppBar(
        toolbarHeight: 85.h,
        leadingWidth: 75.w,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              context.go(Routes.home);
            },
            child: SvgPicture.asset(AppSvgs.backArrow),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(local.my_account, style: AppStyles.w600s20),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w, top: 10.h, bottom: 5.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Dialog(
                          backgroundColor: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 200.w,
                                backgroundImage: NetworkImage(state.userMe!.data.photo),
                                backgroundColor: Colors.grey[200],
                              ),
                              Text("${state.userMe!.data.firstName} ${state.userMe!.data.lastName}", style: AppStyles.w700s24w),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: state.userMe!.data.photo.isEmpty
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
                ),
                SizedBox(height: 4.h),
                Text("${state.userMe!.data.firstName} ${state.userMe!.data.lastName}", style: AppStyles.w400s14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(85.h);
}
