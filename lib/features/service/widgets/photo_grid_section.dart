import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/service/managers/photo/photo_bloc.dart';
import '../managers/photo/photo_event.dart';
import '../managers/photo/photo_state.dart';
import '../widgets/show_select_photos_bottom_sheet.dart';

class PhotoGridSection extends StatelessWidget {
  final TextEditingController themeController;
  final TextEditingController pageCountController;

  const PhotoGridSection({
    super.key,
    required this.themeController,
    required this.pageCountController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        final pageCount = int.tryParse(pageCountController.text) ?? 0;
        final maxSelectable = pageCount ~/ 3;

        return GridView.builder(
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
                  if (themeController.text.isNotEmpty) {
                    if (state.selectedPhotos.length < maxSelectable) {
                      await showModalBottomSheet<List<String>>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.light,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (_) => ShowSelectPhotosBottomSheet(
                          pageCount: maxSelectable,
                          controllerText: themeController.text,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Siz yetarlicha rasm tanlagansiz, avval rasmni o‘chiring.",
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Avval mavzu kiriting.",
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
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
        );
      },
    );
  }
}
