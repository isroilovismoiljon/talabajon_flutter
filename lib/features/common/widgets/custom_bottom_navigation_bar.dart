import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/svgs.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.activeIndex,
  });

  final int activeIndex;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _currentIndex;

  final List<String> _routes = [
    Routes.home,
    Routes.balance,
    Routes.home,
    Routes.settings,
  ];

  @override
  void initState() {
    _currentIndex = widget.activeIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.only(bottom: 25.h, left: 19.w, right: 19.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.transparent,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(
                    index: 0,
                    label: local.home,
                    activeIcon: AppSvgs.homeOn,
                    inactiveIcon: AppSvgs.homeOff,
                  ),
                  _navItem(
                    index: 1,
                    label: local.balanceBottom,
                    activeIcon: AppSvgs.walletOn,
                    inactiveIcon: AppSvgs.walletOff,
                  ),
                  _navItem(
                    index: 2,
                    label: local.documents,
                    activeIcon: AppSvgs.analysisOn,
                    inactiveIcon: AppSvgs.analysisOff,
                  ),
                  _navItem(
                    index: 3,
                    label: local.settings,
                    activeIcon: AppSvgs.userOn,
                    inactiveIcon: AppSvgs.userOff,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String label,
    required String activeIcon,
    required String inactiveIcon,
  }) {
    final bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
        context.go(_routes[index]);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isActive ? activeIcon : inactiveIcon,
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(height: 3.h),
          Text(
            label,
            style: AppStyles.w500s12.copyWith(
              color: isActive ? AppColors.indigoBlue : AppColors.wBlue,
            ),
          ),
        ],
      ),
    );
  }
}
