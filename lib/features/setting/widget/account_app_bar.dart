import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';

import '../../../core/l10n/app_localizations.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return AppBar(
      toolbarHeight: 85.h,
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
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 200.w,
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: AppColors.neonGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 34.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                    color: AppColors.disabledButton,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text("Name Lastname", style: AppStyles.w400s14),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(85.h);
}
