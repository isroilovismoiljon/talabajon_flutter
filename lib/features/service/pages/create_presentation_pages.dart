import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/common/widgets/app_bar_common.dart';
import 'package:talabajon/features/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:talabajon/features/common/widgets/custom_button.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import 'package:talabajon/features/service/managers/photo_bloc.dart';
import 'package:talabajon/features/service/managers/photo_event.dart';
import 'package:talabajon/features/service/managers/photo_state.dart';
import 'package:talabajon/features/service/widgets/custom_empty_field.dart';
import '../../../core/l10n/app_localizations.dart';
import '../widgets/page_count_row.dart';
import '../widgets/show_select_photos_bottom_sheet.dart';

class CreatePresentationPage extends StatefulWidget {
  const CreatePresentationPage({super.key});

  @override
  State<CreatePresentationPage> createState() => _CreatePresentationPageState();
}

class _CreatePresentationPageState extends State<CreatePresentationPage> {
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
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBarCommon(title: local.create_presentation),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 29.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.h,
          children: [
            Column(
              spacing: 10.h,
              children: [
                CustomEmptyField(
                  controller: themeController,
                  titleHint: local.theme,
                  maxLines: 2,
                ),
                CustomEmptyField(
                  controller: authorController,
                  titleHint: local.author,
                ),
              ],
            ),

            PageCountRow(controller: pageCountController),

            CustomSvgButton(
              title: local.select_design,
              svg: AppSvgs.template,
              width: 390,
              height: 48,
            ),

            Container(
              width: 390.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: AppColors.indigoBlue,
                borderRadius: BorderRadius.circular(5.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => togglePhoto(false),
                      icon: const Icon(Icons.image_not_supported_outlined),
                      label: Text(local.no_photo),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(160.w, 35.h),
                        backgroundColor: withPhoto ? AppColors.indigoBlue : AppColors.white,
                        foregroundColor: withPhoto ? AppColors.white : AppColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => togglePhoto(true),
                      icon: const Icon(Icons.photo),
                      label: Text(local.with_photo),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(160.w, 35.h),
                        backgroundColor: withPhoto ? AppColors.white : AppColors.indigoBlue,
                        foregroundColor: withPhoto ? AppColors.black : AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (withPhoto)
              Expanded(
                child: BlocBuilder<PhotoBloc, PhotoState>(
                  builder: (context, state) {
                    final pageCount = int.tryParse(pageCountController.text) ?? 0;
                    final maxSelectable = pageCount ~/ 3;

                    return Container(
                      color: AppColors.white,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.selectedPhotos.length + 1,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          if (index == state.selectedPhotos.length) {
                            return GestureDetector(
                              onTap: () async {
                                if (state.selectedPhotos.length < maxSelectable) {
                                  await showModalBottomSheet<List<String>>(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: AppColors.light,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                    ),

                                    builder: (_) => ShowSelectPhotosBottomSheet(
                                      pageCount: maxSelectable,
                                      controllerText: themeController.text,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Siz yetarlicha rasm tanlagansiz, avval rasmni o‘chiring.",
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppSvgs.galleryAdd,
                                    width: 32.w,
                                    height: 32.h,
                                  ),
                                ),
                              ),
                            );
                          }

                          final photo = state.selectedPhotos[index];
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.network(
                                  photo.thumbnailUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 5.h,
                                right: 5.w,
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<PhotoBloc>().add(RemovePhotoEvent(index));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(1),
                                    child: SvgPicture.asset(
                                      AppSvgs.cancelRed,
                                      width: 18.w,
                                      height: 18.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            else
              const Spacer(),

            CustomButton(title: local.create_presentation),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(activeIndex: 0),
    );
  }
}
