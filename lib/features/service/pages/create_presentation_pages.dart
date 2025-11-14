import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talabajon/features/common/widgets/app_bar_common.dart';
import 'package:talabajon/features/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:talabajon/features/common/widgets/custom_button.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/svgs.dart';
import '../../common/widgets/custom_svg_button.dart';
import '../managers/design/design_bloc.dart';
import '../managers/design/design_state.dart';
import '../widgets/input_fields_section.dart';
import '../widgets/page_count_row.dart';
import '../widgets/photo_grid_section.dart';
import '../widgets/photo_toggle_buttons.dart';
import '../widgets/presentation_template_bottom_sheet.dart';

class CreatePresentationPage extends StatefulWidget {
  const CreatePresentationPage({super.key});

  @override
  State<CreatePresentationPage> createState() => _CreatePresentationPageState();
}

class _CreatePresentationPageState extends State<CreatePresentationPage> with TickerProviderStateMixin {
  late final AnimationController transitionAnimationController;
  final themeController = TextEditingController();
  final authorController = TextEditingController();
  final pageCountController = TextEditingController(text: "10");

  bool withPhoto = false;

  void togglePhoto(bool value) {
    setState(() {
      withPhoto = value;
    });
  }

  @override
  void initState() {
    super.initState();
    transitionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
  }

  @override
  void dispose() {
    transitionAnimationController.dispose();
    themeController.dispose();
    authorController.dispose();
    pageCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBarCommon(title: local.create_presentation),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 29.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.h,
            children: [
              InputFieldsSection(
                themeController: themeController,
                authorController: authorController,
                local: local,
              ),
              PageCountRow(controller: pageCountController),
              CustomSvgButton(
                title: local.select_design,
                svg: AppSvgs.template,
                width: 390,
                height: 48,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    transitionAnimationController: transitionAnimationController,
                    builder: (_) => const PresentationTemplateBottomSheet(),
                  );
                },
              ),
              BlocBuilder<DesignBloc, DesignState>(
                builder: (context, state) {
                  final photoUrl = state.selectedPhotos?.firstPhotoUrl;

                  if (photoUrl == null || photoUrl.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Stack(
                    children: [
                      Container(
                        width: 190.w,
                        height: 115.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            photoUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.w,
                        bottom: 9.h,
                        child: Container(
                          width: 47.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AppSvgs.copy,
                                width: 18.w,
                                height: 18.h,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                              Text(
                                "${state.selectedPhotos!.photoCount}",
                                style: AppStyles.w400s14w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              PhotoToggleButtons(
                withPhoto: withPhoto,
                togglePhoto: togglePhoto,
                local: local,
              ),
              if (withPhoto)
                SizedBox(
                  height: 250.h,
                  child: PhotoGridSection(
                    themeController: themeController,
                    pageCountController: pageCountController,
                  ),
                ),
              CustomButton(title: local.create_presentation),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(activeIndex: 0),
    );
  }
}
