import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import 'package:talabajon/features/service/managers/photo_bloc.dart';
import 'package:talabajon/features/service/managers/photo_state.dart';

import '../../../core/constants/status.dart';
import '../managers/photo_event.dart';

class ShowSelectPhotosBottomSheet extends StatefulWidget {
  final int pageCount;

  const ShowSelectPhotosBottomSheet({super.key, required this.pageCount});

  @override
  State createState() => _ShowSelectPhotosBottomSheetState();
}

class _ShowSelectPhotosBottomSheetState extends State<ShowSelectPhotosBottomSheet> {
  final searchController = TextEditingController();
  final List selectedPhotos = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 146.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  _searchButton("Yandex", AppSvgs.yandex, () {}),
                  _searchButton("Google", AppSvgs.google, () {}),
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(AppSvgs.cancel, width: 24.w, height: 24.h),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          BlocBuilder<PhotoBloc, PhotoState>(
            builder: (context, state) {
              return TextField(
                controller: searchController,
                onChanged: (query) {
                  context.read<PhotoBloc>().add(GoogleEvent(title: query));
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
                  prefixIcon: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Center(
                      child: SvgPicture.asset(
                        AppSvgs.search,
                        colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  hintText: "Search Images",
                  hintStyle: TextStyle(color: AppColors.hintText),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: (selectedPhotos.length < widget.pageCount)
                ? Text(
                    "⚠️ Yana ${widget.pageCount - selectedPhotos.length} ta rasm tanlashingiz kerak",
                    style: AppStyles.w400s12,
                  )
                : const SizedBox.shrink(),
          ),

          SizedBox(height: 16.h),
          SizedBox(
            height: 464.h,
            child: BlocBuilder<PhotoBloc, PhotoState>(
              builder: (context, state) {
                if (state.googleStatus == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.google?.data.photos.isEmpty ?? true) {
                  return const Center(child: Text("Rasmlar topilmadi"));
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 14.w,
                  ),
                  itemCount: state.google!.data.photos.length,
                  itemBuilder: (_, index) {
                    final photo = state.google!.data.photos[index];
                    final tanlangan = selectedPhotos.contains(index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tanlangan) {
                            selectedPhotos.remove(index);
                          } else {
                            if (selectedPhotos.length < widget.pageCount) {
                              selectedPhotos.add(index);
                            }
                          }
                        });
                      },
                      child: Stack(
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) => GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          photo.fullUrl,
                                          fit: BoxFit.contain,
                                          width: 410.w,
                                          height: 600.h,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return SizedBox(
                                              width: 410.w,
                                              height: 600.h,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.white,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                      (loadingProgress.expectedTotalBytes ?? 1)
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) => const Icon(
                                            Icons.broken_image,
                                            color: Colors.red,
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    )

                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                photo.thumbnailUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          if (tanlangan)
                            Positioned(
                              top: 6,
                              right: 6,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(Icons.check, size: 14, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          CustomSvgButton(
            title: "Add Photos",
            svg: AppSvgs.addCircle,
            width: 390,
            height: 54,
            onPressed: () {
              final state = context.read<PhotoBloc>().state;
              final tanlanganRasmlar = selectedPhotos.map((index) => state.google!.data.photos[index].thumbnailUrl).toList();
              context.pop(tanlanganRasmlar);
            },
          ),

          SizedBox(height: 9.h),
        ],
      ),
    );
  }

  Widget _searchButton(String text, String svg, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(svg, width: 18.w, height: 18.h),
            SizedBox(width: 5.w),
            Text(text, style: AppStyles.w600s13w),
          ],
        ),
      ),
    );
  }
}
