import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/utils/styles.dart';

import '../../../core/utils/svgs.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCommon({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leadingWidth: 75,
      leading: Center(
        child: IconButton(
          onPressed: (){context.pop();},
          icon: SvgPicture.asset(AppSvgs.backArrow),
        ),
      ),
      centerTitle: true,
      title: Text(title, style: AppStyles.w500s24),
      actions: [
        SvgPicture.asset(AppSvgs.chat),
        SizedBox(width: 20.w)
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 56.h);
}
