import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/common/widgets/app_bar_common.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<String> _rasmlar = [
    "https://picsum.photos/400/244?1",
    "https://picsum.photos/400/244?2",
    "https://picsum.photos/400/244?3",
    "https://picsum.photos/400/244?4",
  ];

  void _oldinga() {
    if (_currentIndex < _rasmlar.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _orqaga() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(title: "Update Presentation"),
      body: Padding(
        padding: EdgeInsets.only(bottom: 51.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 59.h,
              decoration: BoxDecoration(
                color: AppColors.indigoBlue,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("File", style: AppStyles.w600s20w),
                  Row(
                    spacing: 15.w,
                    children: [
                      GestureDetector(
                        onTap: _orqaga,
                        child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
                      ),
                      GestureDetector(
                        onTap: _oldinga,
                        child: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: _rasmlar.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      width: 338.67.w,
                      height: 190.5.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.45),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(_rasmlar[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                itemCount: _rasmlar.length,
                itemBuilder: (context, index) {
                  final isSelected = _currentIndex == index;
                  return GestureDetector(
                    onTap: () {
                      _controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      width: 150.w,
                      height: 91.5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.indigoBlue : AppColors.black,
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(_rasmlar[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 46.5.h),
            CustomSvgButton(title: "Save Presentation", svg: AppSvgs.mingcuteSave, width: 400, height: 45),
          ],
        ),
      ),
    );
  }
}
