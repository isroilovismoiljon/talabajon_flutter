import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/common/widgets/app_bar_common.dart';
import 'package:talabajon/features/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:talabajon/features/common/widgets/custom_button.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import 'package:talabajon/features/service/widgets/custom_empty_field.dart';

import '../widgets/page_count_row.dart'; // 👈 import

class CreatePresentationPage extends StatefulWidget {
  const CreatePresentationPage({super.key});

  @override
  State<CreatePresentationPage> createState() => _CreatePresentationPageState();
}

class _CreatePresentationPageState extends State<CreatePresentationPage> {
  final themeController = TextEditingController();
  final authorController = TextEditingController();
  final pageCountController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCommon(title: "Create presentation"),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 29.h),
        child: Column(
          spacing: 20.h,
          children: [
            Column(
              spacing: 10.h,
              children: [
                CustomEmptyField(
                  controller: themeController,
                  titleHint: 'Theme',
                  maxLines: 2,
                ),
                CustomEmptyField(
                  controller: authorController,
                  titleHint: 'Author',
                ),
              ],
            ),
            PageCountRow(controller: pageCountController),
            CustomSvgButton(
              title: "Select Design",
              svg: AppSvgs.template,
              width: 390,
              height: 48,
            ),
            const Spacer(),
            const CustomButton(title: "Create Presentation"),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(activeIndex: 0),
    );
  }
}
