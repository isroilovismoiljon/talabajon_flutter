import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import 'package:talabajon/features/service/managers/photo/photo_bloc.dart';
import 'package:translator/translator.dart';

import '../../../core/constants/status.dart';
import '../managers/photo/photo_event.dart';
import '../managers/photo/photo_state.dart';

class ShowSelectPhotosBottomSheet extends StatefulWidget {
  final int pageCount;
  final String controllerText;

  const ShowSelectPhotosBottomSheet({
    super.key,
    required this.pageCount,
    required this.controllerText,
  });

  @override
  State createState() => _ShowSelectPhotosBottomSheetState();
}

class _ShowSelectPhotosBottomSheetState extends State<ShowSelectPhotosBottomSheet> {
  final searchController = TextEditingController();
  final translator = GoogleTranslator();
  final random = Random();

  String currentSource = "yandex";

  @override
  void initState() {
    super.initState();
    context.read<PhotoBloc>().add(SetPhotoLimitEvent(widget.pageCount));
    searchController.text = widget.controllerText;
    currentSource == "google"
        ? context.read<PhotoBloc>().add(GoogleEvent(title: searchController.text))
        : context.read<PhotoBloc>().add(YandexEvent(title: searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        final currentStatus = currentSource == "google" ? state.googleStatus : state.yandexState;
        final currentData = currentSource == "google" ? state.google : state.yandex;
        final remainingPhotos = state.pageCount - state.selectedPhotos.length;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 146.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _searchButton(
                        "Yandex",
                        AppSvgs.yandex,
                        currentSource == "yandex",
                        () {
                          setState(() => currentSource = "yandex");
                          context.read<PhotoBloc>().add(YandexEvent(title: searchController.text));
                        },
                      ),
                      SizedBox(width: 8.w),
                      _searchButton(
                        "Google",
                        AppSvgs.google,
                        currentSource == "google",
                        () {
                          setState(() => currentSource = "google");
                          context.read<PhotoBloc>().add(GoogleEvent(title: searchController.text));
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(
                      AppSvgs.cancel,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              TextField(
                controller: searchController,
                onChanged: (query) async {
                  if (query.trim().isEmpty) return;

                  final translation = await translator.translate(query, to: 'en');

                  if (currentSource == "google") {
                    context.read<PhotoBloc>().add(GoogleEvent(title: translation.text));
                  } else {
                    context.read<PhotoBloc>().add(YandexEvent(title: translation.text));
                  }
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
                ),
              ),
              SizedBox(height: 10.h),

              if (remainingPhotos > 0)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "⚠️ Yana $remainingPhotos ta rasm tanlashingiz mumkin",
                    style: AppStyles.w400s12,
                  ),
                ),
              if (remainingPhotos == 0)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "✅ Limit to‘ldi, endi 'Add Photos' tugmasini bosing",
                    style: AppStyles.w400s12.copyWith(color: Colors.green),
                  ),
                ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 464.h,
                child: Builder(
                  builder: (_) {
                    if (currentStatus == Status.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (currentData?.data.photos.isEmpty ?? true) {
                      return const Center(child: Text("Rasmlar topilmadi"));
                    }

                    final photos = currentData!.data.photos;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 14.w,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (_, index) {
                        final photo = photos[index];
                        final selected = state.selectedPhotos.any((p) => p.id == photo.id);

                        bool isError = false; // 🔹 yangi flag

                        return StatefulBuilder(
                          builder: (context, setInnerState) {
                            return isError
                                ? const SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () {
                                      if (!isError && (state.selectedPhotos.length < state.pageCount || selected)) {
                                        context.read<PhotoBloc>().add(TogglePhotoSelectionEvent(photo));
                                      }
                                    },
                                    onLongPress: () {
                                      if (isError) return;
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) => GestureDetector(
                                          onTap: () => context.pop(),
                                          child: Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: Center(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12.r),
                                                child: Image.network(
                                                  photo.fullUrl,
                                                  fit: BoxFit.contain,
                                                  width: 410.w,
                                                  height: 600.h,
                                                  loadingBuilder: (context, child, progress) {
                                                    if (progress == null) return child;
                                                    return SizedBox(
                                                      width: 410.w,
                                                      height: 600.h,
                                                      child: const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context, error, stackTrace) {
                                                    Future.microtask(() => setInnerState(() => isError = true));
                                                    return const SizedBox.shrink();
                                                  },

                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                              255,
                                              random.nextInt(256),
                                              random.nextInt(256),
                                              random.nextInt(256),
                                            ),
                                            borderRadius: BorderRadius.circular(12.r),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12.r),
                                          child: Image.network(
                                            photo.thumbnailUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            errorBuilder: (context, error, stackTrace) {
                                              Future.microtask(() => setInnerState(() => isError = true));
                                              return const SizedBox.shrink();
                                            },

                                          ),
                                        ),
                                        if (selected)
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
                  context.pop();
                },
              ),
              SizedBox(height: 9.h),
            ],
          ),
        );
      },
    );
  }

  Widget _searchButton(String text, String svg, bool isActive, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.indigoBlue.withValues(alpha: 0.8) : AppColors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8.r),
          border: isActive ? Border.all(color: AppColors.white, width: 1.2) : null,
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
